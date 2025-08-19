import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/atividade_repository.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/core/upload/upload_manager.dart';

/// 🔄 Serviço de sincronização em background
///
/// Responsabilidades:
/// - Verifica atividades concluídas a cada 15 minutos
/// - Adiciona atividades na fila de upload
/// - Processa a fila quando há conexão WiFi
/// - Gerencia timers e estado de conectividade
class BackgroundSyncService extends GetxService {
  final AtividadeRepository _atividadeRepository;
  final UploadManager _uploadManager;

  //timer para verificar atividades concluídas e pendentes de upload
  Timer? _verificacaoTimer;
  //timer para verificar se há conexão com a internet
  Timer? _sincronizacaoTimer;
  bool _executando = false;
  bool _temConexao = false;

  // Reatividade para UI
  final RxBool executandoRx = false.obs;
  final RxBool temConexaoRx = false.obs;
  final Rx<ConnectivityResult?> ultimoTipoConexaoRx = Rx<ConnectivityResult?>(null);

  // Política de rede
  final bool _wifiApenas = true; // requisito padrão: apenas Wi‑Fi
  static const bool permitirQualquerRedeEmDebug = true; // facilita testes em emulador

  // Configurações
  static const Duration _intervaloVerificacao = Duration(minutes: 15);
  static const Duration _intervaloSincronizacao = Duration(minutes: 5);
  static const Duration _intervaloRetryCurto = Duration(seconds: 30);

  BackgroundSyncService({
    required AtividadeRepository atividadeRepository,
    required UploadManager uploadManager,
  })  : _atividadeRepository = atividadeRepository,
        _uploadManager = uploadManager;

  /// 🚀 Inicia o serviço de background
  Future<void> iniciar() async {
    if (_executando) {
      AppLogger.w('⚠️ BackgroundSyncService já está executando');
      return;
    }

    AppLogger.d('🚀 Iniciando BackgroundSyncService');
    _executando = true;
    executandoRx.value = true;

    // Verificar conectividade inicial
    await _verificarConectividade();

    // Iniciar timers
    _iniciarTimerVerificacao();
    _iniciarTimerSincronizacao();

    // Executar verificação inicial
    await _verificarAtividadesConcluidas();

    AppLogger.d('✅ BackgroundSyncService iniciado com sucesso');
  }

  /// ⏹️ Para o serviço de background
  Future<void> parar() async {
    if (!_executando) {
      AppLogger.w('⚠️ BackgroundSyncService não está executando');
      return;
    }

    AppLogger.d('⏹️ Parando BackgroundSyncService');
    _executando = false;
    executandoRx.value = false;

    _verificacaoTimer?.cancel();
    _sincronizacaoTimer?.cancel();

    AppLogger.d('✅ BackgroundSyncService parado');
  }

  /// 🔄 Verifica conectividade com a internet
  Future<void> _verificarConectividade() async {
    // Melhoria: verificação simples de reachability (DNS) + tentativa leve ao backend
    try {
      // Verifica tipo de rede
      final connectivityResult = await Connectivity().checkConnectivity();
      // ultimoTipoConexaoRx.value = connectivityResult;
      final onWifi = connectivityResult.contains(ConnectivityResult.wifi);

      // Checagem rápida de reachability
      final resultado = await InternetAddress.lookup('google.com');
      final dnsOk = resultado.isNotEmpty && resultado[0].rawAddress.isNotEmpty;

      // Avalia requisito de rede
      bool atendeTipoRede =
          _wifiApenas ? onWifi : (!connectivityResult.contains(ConnectivityResult.none));
      if (!atendeTipoRede && kDebugMode && permitirQualquerRedeEmDebug) {
        // Em debug, permite qualquer rede diferente de none (útil para emulador)
        atendeTipoRede = !connectivityResult.contains(ConnectivityResult.none);
        AppLogger.d(
            '🧪 Debug: liberando requisito de Wi‑Fi para testes (tipo: $connectivityResult)');
      }

      final novaConectividade = atendeTipoRede && dnsOk;

      AppLogger.d(
          '🌐 Check conectividade → tipo=$connectivityResult, wifiApenas=$_wifiApenas, dnsOk=$dnsOk, atendeTipo=$atendeTipoRede, novaConectividade=$novaConectividade');

      if (_temConexao != novaConectividade) {
        _temConexao = novaConectividade;
        temConexaoRx.value = _temConexao;
        AppLogger.d('🌐 Conectividade alterada: ${_temConexao ? "Conectado" : "Desconectado"}');

        if (_temConexao) {
          // ao reconectar, agenda uma tentativa curta para escoar fila rapidamente
          unawaited(_agendarRetryCurto());
        }
      }
    } catch (e) {
      if (_temConexao) {
        _temConexao = false;
        temConexaoRx.value = _temConexao;
        AppLogger.d('🌐 Conectividade perdida');
      }
    }
  }

  Future<void> _agendarRetryCurto() async {
    await Future.delayed(_intervaloRetryCurto);
    if (_executando && _temConexao) {
      await _processarFilaUpload();
    }
  }

  /// ⏰ Inicia o timer de verificação de atividades concluídas
  void _iniciarTimerVerificacao() {
    _verificacaoTimer?.cancel();
    _verificacaoTimer = Timer.periodic(_intervaloVerificacao, (timer) async {
      if (!_executando) {
        timer.cancel();
        return;
      }

      AppLogger.d('⏰ Timer de verificação executado');
      await _verificarAtividadesConcluidas();
    });

    AppLogger.d('⏰ Timer de verificação iniciado (${_intervaloVerificacao.inMinutes} min)');
  }

  /// ⏰ Inicia o timer de sincronização
  void _iniciarTimerSincronizacao() {
    _sincronizacaoTimer?.cancel();
    _sincronizacaoTimer = Timer.periodic(_intervaloSincronizacao, (timer) async {
      if (!_executando) {
        timer.cancel();
        return;
      }

      AppLogger.d('⏰ Timer de sincronização executado');
      await _verificarConectividade();

      if (_temConexao) {
        await _processarFilaUpload();
      }
    });

    AppLogger.d('⏰ Timer de sincronização iniciado (${_intervaloSincronizacao.inMinutes} min)');
  }

  /// 🔍 Verifica atividades concluídas e adiciona na fila de upload
  Future<void> _verificarAtividadesConcluidas() async {
    try {
      AppLogger.d('🔍 Verificando atividades concluídas e pendentes de upload...');

      // Buscar atividades com status "concluido" e "pendenteUpload"
      final atividadesParaUpload = await _atividadeRepository.buscarAtividadesPorStatuses([
        StatusAtividade.concluido,
        StatusAtividade.pendenteUpload,
      ]);

      if (atividadesParaUpload.isEmpty) {
        AppLogger.d('📭 Nenhuma atividade para upload encontrada');
        return;
      }

      AppLogger.d('📋 Encontradas ${atividadesParaUpload.length} atividades para upload');

      // Adicionar cada atividade na fila de upload
      for (final atividade in atividadesParaUpload) {
        AppLogger.d('📤 Adicionando atividade ${atividade.uuid} na fila de upload');
        await _uploadManager.adicionarNaFila(atividade.uuid);
      }

      AppLogger.d('✅ ${atividadesParaUpload.length} atividades adicionadas na fila');
    } catch (e, s) {
      AppLogger.e('❌ Erro ao verificar atividades para upload', error: e, stackTrace: s);
    }
  }

  /// 📤 Processa a fila de upload se houver conexão
  Future<void> _processarFilaUpload() async {
    if (!_temConexao) {
      AppLogger.d('🌐 Sem conexão, pulando processamento da fila');
      return;
    }

    if (_uploadManager.filaVazia) {
      AppLogger.d('📭 Fila de upload vazia');
      return;
    }

    if (_uploadManager.estaProcessando) {
      AppLogger.d('⏳ Upload já está em processamento');
      return;
    }

    try {
      AppLogger.d('🚀 Processando fila de upload (${_uploadManager.tamanhoFila} itens)');
      await _uploadManager.processarFila();
      AppLogger.d('✅ Fila de upload processada');
    } catch (e, s) {
      AppLogger.e('❌ Erro ao processar fila de upload', error: e, stackTrace: s);
    }
  }

  /// 🔧 Força uma verificação manual (útil para testes)
  Future<void> verificarManual() async {
    AppLogger.d('🔧 Verificação manual solicitada');
    await _verificarAtividadesConcluidas();
  }

  /// 🔧 Força uma sincronização manual (útil para testes)
  Future<void> sincronizarManual() async {
    AppLogger.d('🔧 Sincronização manual solicitada');
    await _verificarConectividade();
    if (_temConexao) {
      await _processarFilaUpload();
    }
  }

  /// 📊 Retorna o status atual do serviço
  Map<String, dynamic> get status {
    return {
      'executando': _executando,
      'temConexao': _temConexao,
      'tamanhoFila': _uploadManager.tamanhoFila,
      'estaProcessando': _uploadManager.estaProcessando,
      'intervaloVerificacao': _intervaloVerificacao.inMinutes,
      'intervaloSincronizacao': _intervaloSincronizacao.inMinutes,
    };
  }

  @override
  void onClose() {
    parar();
    super.onClose();
  }
}
