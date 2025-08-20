import 'package:get/get.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/atividade_repository.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/core/upload/upload_item.dart';
import 'package:sympla_app/core/upload/upload_queue.dart';
import 'package:sympla_app/core/upload/upload_service.dart';

/// 📦 Gerenciador de upload
///
/// Responsabilidades:
/// - Gerencia a fila de upload
/// - Processa a fila de upload
/// - Envia atividades para o servidor
/// - Marca atividades como sincronizadas ou pendentes
/// - Gerencia o estado de processamento
class UploadManager {
  final DioClient _dio;
  final AtividadeRepository _atividadeRepo;

  final UploadQueue _fila = UploadQueue();
  final UploadService _uploadService;

  bool _processando = false;

  // Reatividade para UI
  final RxBool estaProcessandoRx = false.obs;
  final RxInt tamanhoFilaRx = 0.obs;

  UploadManager({
    required DioClient dio,
    required AtividadeRepository atividadeRepo,
    required UploadService uploadService,
  })  : _dio = dio,
        _atividadeRepo = atividadeRepo,
        _uploadService = uploadService;

  /// Adiciona uma atividade na fila de upload
  Future<void> adicionarNaFila(String atividadeId) async {
    try {
      AppLogger.d('📤 Adicionando atividade $atividadeId na fila de upload');

      // Montar o AtividadeSyncDto completo
      final atividadeSync = await _uploadService.montarAtividadeSync(atividadeId);
      if (atividadeSync == null) {
        AppLogger.e('❌ Não foi possível montar AtividadeSyncDto para $atividadeId');
        return;
      }

      // Evita duplicidade na fila
      if (_fila.contem(atividadeId)) {
        AppLogger.w('⚠️ Atividade $atividadeId já está na fila, ignorando');
        return;
      }

      // Criar UploadItem e adicionar na fila
      final uploadItem = UploadItem(atividadeSync);
      _fila.adicionar(uploadItem);
      tamanhoFilaRx.value = _fila.tamanho;

      AppLogger.d('✅ Atividade $atividadeId adicionada na fila. Total na fila: ${_fila.tamanho}');
    } catch (e, s) {
      AppLogger.e('❌ Erro ao adicionar atividade $atividadeId na fila', error: e, stackTrace: s);
    }
  }

  /// Processa toda a fila de upload
  Future<void> processarFila() async {
    if (_processando) {
      AppLogger.w('⚠️ Upload já está em processamento');
      return;
    }

    _processando = true;
    estaProcessandoRx.value = true;
    AppLogger.d('🚀 Iniciando processamento da fila de upload. Total: ${_fila.tamanho}');

    try {
      // Processa apenas itens elegíveis no momento; se nenhum elegível, encerra
      while (true) {
        final item = _fila.proximo();
        if (item == null) break;
        tamanhoFilaRx.value = _fila.tamanho;
        await _processarItem(item);
        tamanhoFilaRx.value = _fila.tamanho;
      }

      AppLogger.d('✅ Fila de upload processada com sucesso');
    } catch (e, s) {
      AppLogger.e('❌ Erro ao processar fila de upload', error: e, stackTrace: s);
    } finally {
      _processando = false;
      estaProcessandoRx.value = false;
    }
  }

  /// Processa um item específico da fila
  Future<void> _processarItem(UploadItem item) async {
    try {
      AppLogger.d('📤 Processando upload da atividade: ${item.atividadeSync.uuid}');

      final sucesso = await enviarAtividade(item);

      if (sucesso) {
        AppLogger.d('✅ Atividade ${item.atividadeSync.uuid} enviada com sucesso');
        await _marcarComoSincronizada(item.atividadeSync.uuid);
      } else {
        AppLogger.e('❌ Falha ao enviar atividade ${item.atividadeSync.uuid}');
        await _marcarComoPendente(item.atividadeSync.uuid);
        // Se ainda pode tentar, define backoff e só re-enfileira para próxima janela
        if (item.podeTentarNovamente) {
          _aplicarBackoff(item);
          _fila.adicionar(item);
          AppLogger.d('🔄 Reagendado ${item.atividadeSync.uuid} para ${item.proximaTentativa}');
          tamanhoFilaRx.value = _fila.tamanho;
        } else {
          AppLogger.w('🛑 Máximo de tentativas atingido para ${item.atividadeSync.uuid}');
        }
      }
    } catch (e, s) {
      AppLogger.e('❌ Erro ao processar item da fila', error: e, stackTrace: s);
      item.marcarErro(e.toString());

      if (item.podeTentarNovamente) {
        _aplicarBackoff(item);
        _fila.adicionar(item);
        tamanhoFilaRx.value = _fila.tamanho;
      }
    }
  }

  /// Envia uma atividade para o servidor
  Future<bool> enviarAtividade(UploadItem item) async {
    try {
      AppLogger.d('🌐 Enviando atividade ${item.atividadeSync.uuid} para o servidor');

      // Converter AtividadeSyncDto para JSON
      final jsonData = item.atividadeSync.toJson();

      // Fazer requisição POST
      final response = await _dio.post(
        '${ApiConstants.uploadAtividade}/${item.atividadeSync.uuid}',
        data: jsonData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppLogger.d('✅ Resposta do servidor: ${response.statusCode}');
        return true;
      } else {
        final statusCode = response.statusCode ?? 0;
        final mensagem = 'Erro do servidor: $statusCode';
        AppLogger.e('❌ $mensagem');
        // incrementa tentativa também em erro HTTP
        item.marcarErro(mensagem);
        // decide retryability: 5xx, 408, 429 normalmente são retryáveis; 4xx em geral não
        if (statusCode >= 500 || statusCode == 408 || statusCode == 429) {
          return false; // retryável
        }
        // 4xx (exceto 408/429) considerado não retryável
        item.tentativas = UploadItem.maxTentativas; // força esgotar
        return false;
      }
    } catch (e, s) {
      AppLogger.e('❌ Erro ao enviar atividade ${item.atividadeSync.uuid}', error: e, stackTrace: s);
      item.marcarErro(e.toString());
      return false;
    }
  }

  void _aplicarBackoff(UploadItem item) {
    // Backoff exponencial simples: 2^tentativas segundos, com teto de 120s
    final int tentativasClamped = item.tentativas.clamp(0, 6).toInt();
    final int segundos = 1 << tentativasClamped;
    final delay = Duration(seconds: segundos > 120 ? 120 : segundos);
    item.proximaTentativa = DateTime.now().add(delay);
  }

  /// Marca atividade como sincronizada no banco local
  Future<void> _marcarComoSincronizada(String atividadeId) async {
    try {
      final atividade = await _atividadeRepo.buscarAtividade(atividadeId);
      if (atividade != null) {
        await _atividadeRepo
            .atualizarAtividade(atividade.copyWith(status: StatusAtividade.sincronizado));
        AppLogger.d('✅ Atividade $atividadeId marcada como sincronizada');
      }
    } catch (e, s) {
      AppLogger.e('❌ Erro ao marcar atividade como sincronizada', error: e, stackTrace: s);
    }
  }

  /// Marca atividade como pendente de upload no banco local
  Future<void> _marcarComoPendente(String atividadeId) async {
    try {
      final atividade = await _atividadeRepo.buscarAtividade(atividadeId);
      if (atividade != null) {
        await _atividadeRepo
            .atualizarAtividade(atividade.copyWith(status: StatusAtividade.pendenteUpload));
        AppLogger.d('⚠️ Atividade $atividadeId marcada como pendente de upload');
      }
    } catch (e, s) {
      AppLogger.e('❌ Erro ao marcar atividade como pendente', error: e, stackTrace: s);
    }
  }

  /// Retorna informações sobre o estado da fila
  bool get estaProcessando => _processando;
  int get tamanhoFila => _fila.tamanho;
  bool get filaVazia => _fila.estaVazia;

  // Getters reativos de conveniência
  RxBool get estaProcessandoStream => estaProcessandoRx;
  RxInt get tamanhoFilaStream => tamanhoFilaRx;

  /// Limpa a fila de upload
  void limparFila() {
    _fila.limpar();
    AppLogger.d('🗑️ Fila de upload limpa');
    tamanhoFilaRx.value = _fila.tamanho;
  }
}
