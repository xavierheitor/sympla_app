import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/constants/etapas_atividade.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/constants/tipo_atividade_mobile.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/modules/home/atividade_service.dart';
import 'package:sympla_app/core/syncService/atividade/atividade_sync_service.dart';
import 'package:sympla_app/core/session/session_manager.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/core/data/models/atividade_model.dart';

class AtividadeController extends GetxController {
  //servicos da atividade
  final AtividadeService atividadeService;
  final AtividadeSyncService atividadeSyncService;

  //lista de atividades
  final RxList<AtividadeModel> atividades = <AtividadeModel>[].obs;

  //loading
  final RxBool isLoading = false.obs;

  //contadores
  final RxInt atividadesPendentes = 0.obs;
  final RxInt atividadesConcluidas = 0.obs;
  final RxInt atividadesCanceladas = 0.obs;
  final RxInt atividadesEmAndamento = 0.obs;

  //atividade em andamento
  final Rx<AtividadeModel?> atividadeEmAndamento = Rx<AtividadeModel?>(null);

  //etapa atual
  final Rx<EtapaAtividade?> etapaAtual = Rx<EtapaAtividade?>(null);

  AtividadeController({
    required this.atividadeService,
    required this.atividadeSyncService,
  });

  //inicializacao
  @override
  Future<void> onInit() async {
    super.onInit();
    //verifica se o usuario esta logado
    final session = Get.find<SessionManager>();
    if (!session.estaLogado) {
      AppLogger.w(
          '🔐 Usuário não logado. Pulando carga inicial de atividades.');
      session.logout();
      return;
    }

    //carrega as atividades
    AppLogger.d('🚀 Iniciando carregamento de atividades...',
        tag: 'AtividadeController');
    await carregarAtividades();
  }

  //sincroniza as atividades chamando o servico de sincronizacao
  Future<void> sincronizarAtividades() async {
    try {
      isLoading.value = true;
      AppLogger.d('📡 Sincronizando atividades...', tag: 'AtividadeController');
      await atividadeSyncService.sincronizar();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[sincronizarAtividades] ${erro.mensagem}',
          tag: 'AtividadeController', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao sincronizar atividades',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  //carrega as atividades do banco de dados chamando o servico de atividade
  Future<void> carregarAtividades() async {
    try {
      isLoading.value = true;

      //verifica se o banco esta vazio
      final vazio = await atividadeSyncService.estaVazio();
      if (vazio) {
        AppLogger.d('📡 Banco vazio, iniciando sincronização...',
            tag: 'AtividadeController');
        await atividadeSyncService.sincronizar();
      }

      //carrega as atividades com equipamento
      final listaComEquipamento = await atividadeService.buscarComEquipamento();
      atividades.assignAll(listaComEquipamento);

      //atualiza os contadores
      _atualizarContadores();

      //busca a atividade em andamento
      await _buscarAtividadeEmAndamento();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[carregarAtividades] ${erro.mensagem}',
          tag: 'AtividadeController', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao carregar atividades',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  //atualiza os contadores com base na lista de atividades
  void _atualizarContadores() {
    atividadesPendentes.value = 0;
    atividadesConcluidas.value = 0;
    atividadesCanceladas.value = 0;
    atividadesEmAndamento.value = 0;

    for (var atividade in atividades) {
      switch (atividade.status) {
        case StatusAtividade.pendente:
          atividadesPendentes.value++;
          break;
        case StatusAtividade.concluido:
          atividadesConcluidas.value++;
          break;
        case StatusAtividade.cancelado:
          atividadesCanceladas.value++;
          break;
        case StatusAtividade.emAndamento:
          atividadesEmAndamento.value++;
          break;
        case StatusAtividade.sincronizado:
          break;
      }
    }

    AppLogger.d(
      '📊 Pendentes: ${atividadesPendentes.value}, Concluídas: ${atividadesConcluidas.value}, Canceladas: ${atividadesCanceladas.value}, Em andamento: ${atividadesEmAndamento.value}',
      tag: 'AtividadeController',
    );
  }

  //busca a atividade em andamento no banco de dados
  Future<void> _buscarAtividadeEmAndamento() async {
    try {
      final atividade = await atividadeService.buscarAtividadeEmAndamento();
      atividadeEmAndamento.value = atividade;

      if (atividade != null) {
        etapaAtual.value = EtapaAtividade.apr;
        AppLogger.d(
            '✅ Atividade em andamento encontrada (ID: ${atividade.id}), etapa inicial: APR',
            tag: 'AtividadeController');
      } else {
        AppLogger.d('ℹ️ Nenhuma atividade em andamento encontrada.',
            tag: 'AtividadeController');
      }
    } catch (e, s) {
      AppLogger.e('[buscarAtividadeEmAndamento] erro',
          tag: 'AtividadeController', error: e, stackTrace: s);
    }
  }

  //inicia a atividade salva no banco e manda executar a atividade
  Future<void> iniciarAtividade(AtividadeModel atividade) async {
    try {
      AppLogger.d('⚙️ Iniciando atividade ID: ${atividade.id}',
          tag: 'AtividadeController');

      //atualiza a atividade em andamento
      atividadeEmAndamento.value = atividade;

      //inicia a atividade no banco de dados
      await atividadeService.iniciarAtividade(atividade);

      //atualiza a lista de atividades
      final index = atividades.indexWhere((a) => a.id == atividade.id);
      if (index != -1) {
        atividades[index] =
            atividade.copyWithStatus(StatusAtividade.emAndamento);
        atividades.refresh();
        atividadeEmAndamento.value = atividades[index];
        _atualizarContadores();
      }

      // 🧠 Não define etapaAtual aqui — deixa o executarAtividade resolver se necessário
      await executarAtividade(atividadeEmAndamento.value!);
    } catch (e, s) {
      atividadeEmAndamento.value = null;
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[iniciarAtividade] ${erro.mensagem}',
          tag: 'AtividadeController', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao iniciar atividade',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  //finaliza a atividade no banco de dados e faz as tratativas relacionadas
  Future<void> finalizarAtividade(AtividadeModel atividade) async {
    try {
      await atividadeService.finalizarAtividade(atividade);
      atividadeEmAndamento.value = null;
      etapaAtual.value = null;

      await carregarAtividades();

      Get.snackbar('Sucesso', 'Atividade finalizada com sucesso',
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.offAllNamed(Routes.home);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[finalizarAtividade] ${erro.mensagem}',
          tag: 'AtividadeController', error: e, stackTrace: s);
    }
  }

  //pega o tipo da atividade no banco
  Future<TipoAtividadeMobile> _tipoAtividadeMobileDo(
      AtividadeModel atividade) async {
    final tipoAtividade = await atividadeService.getTipoAtividadeId(atividade);
    return tipoAtividade.tipoAtividadeMobile;
  }

  Future<EtapaAtividade?> _proximaEtapa(
      AtividadeModel atividade, EtapaAtividade etapaAtual) async {
    final tipo = await _tipoAtividadeMobileDo(atividade);
    final etapas = fluxoPorTipoAtividade[tipo] ?? [];
    final idx = etapas.indexOf(etapaAtual);
    return (idx >= 0 && idx + 1 < etapas.length) ? etapas[idx + 1] : null;
  }

  Future<void> avancar() async {
    final atividade = atividadeEmAndamento.value;
    var etapa = etapaAtual.value;

    if (atividade == null) {
      AppLogger.w('⚠️ Tentativa de avançar sem atividade em andamento',
          tag: 'AtividadeController');
      return;
    }

    // Se etapa atual estiver nula, assume a primeira do fluxo
    if (etapa == null) {
      final tipo = await _tipoAtividadeMobileDo(atividade);
      final fluxo = fluxoPorTipoAtividade[tipo];
      if (fluxo == null || fluxo.isEmpty) {
        AppLogger.w('⚠️ Nenhum fluxo definido para tipo $tipo',
            tag: 'AtividadeController');
        return;
      }
      etapa = fluxo.first;
      etapaAtual.value = etapa;
    }

    //pega a proxima etapa
    final proxima = await _proximaEtapa(atividade, etapa);

    //se a etapa atual for a ultima, finaliza a atividade
    if (proxima == null) {
      AppLogger.d('🏁 Etapa final atingida. Executando finalização...',
          tag: 'AtividadeController');
      etapaAtual.value = EtapaAtividade.finalizada;
      await finalizarAtividade(atividade);
      return;
    }

    //atualiza a etapa atual
    etapaAtual.value = proxima;

    //executa a atividade
    await executarAtividade(atividade);
  }

  Future<void> executarAtividade(AtividadeModel atividade) async {
    // 🧠 Garante etapa inicial se não estiver setada
    if (etapaAtual.value == null) {
      final tipoMobile = await _tipoAtividadeMobileDo(atividade);
      final fluxo = fluxoPorTipoAtividade[tipoMobile];

      if (fluxo == null || fluxo.isEmpty) {
        AppLogger.w('⚠️ Nenhum fluxo definido para $tipoMobile',
            tag: 'AtividadeController');
        return;
      }

      etapaAtual.value = fluxo.first;
      AppLogger.i(
          'ℹ️ Nenhuma etapa definida, assumindo etapa inicial: ${etapaAtual.value}',
          tag: 'AtividadeController');
    }

    final etapa = etapaAtual.value!;
    AppLogger.d(
        '➡️ Executando etapa: $etapa para atividade ID: ${atividade.id}',
        tag: 'AtividadeController');

    final sempreMostra = etapasSempreMostram[etapa] ?? false;
    if (!sempreMostra) {
      final podePular = await _etapaDesejaPular(etapa);
      if (podePular) {
        AppLogger.d('⏭️ Etapa $etapa será pulada.', tag: 'AtividadeController');
        await avancar();
        return;
      }
    }

    switch (etapa) {
      case EtapaAtividade.apr:
        Get.toNamed(Routes.apr);
        break;
      case EtapaAtividade.checklist:
        Get.toNamed(Routes.checklist);
        break;
      case EtapaAtividade.resumoAnomalias:
        Get.toNamed(Routes.resumoAnomalias);
        break;
      case EtapaAtividade.mpBbForm:
        Get.toNamed(Routes.mpBbForm);
        break;
      case EtapaAtividade.mpDjForm:
        Get.toNamed(Routes.mpDjForm);
        break;
      case EtapaAtividade.finalizada:
        await finalizarAtividade(atividade);
        break;
    }
  }

  Future<bool> _etapaDesejaPular(EtapaAtividade etapa) async {
    // ⚠️ Etapas não devem ser puladas por enquanto
    return false;
  }
}
