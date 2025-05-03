import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/modules/home/atividade_service.dart';
import 'package:sympla_app/core/syncService/atividade/atividade_sync_service.dart';
import 'package:sympla_app/core/session/session_manager.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/core/data/models/atividade_model.dart';

class AtividadeController extends GetxController {
  final AtividadeService atividadeService;
  final AtividadeSyncService atividadeSyncService;

  final RxList<AtividadeModel> atividades = <AtividadeModel>[].obs;
  final RxBool isLoading = false.obs;

  final RxInt atividadesPendentes = 0.obs;
  final RxInt atividadesConcluidas = 0.obs;
  final RxInt atividadesCanceladas = 0.obs;
  final RxInt atividadesEmAndamento = 0.obs;

  final Rx<AtividadeModel?> atividadeEmAndamento = Rx<AtividadeModel?>(null);

  AtividadeController({
    required this.atividadeService,
    required this.atividadeSyncService,
  });

  @override
  Future<void> onInit() async {
    super.onInit();
    final session = Get.find<SessionManager>();

    if (!session.estaLogado) {
      AppLogger.w(
          '🔐 Usuário não logado. Pulando carga inicial de atividades.');
      session.logout();
      return;
    }
    await carregarAtividades();
  }

  Future<void> carregarAtividades() async {
    try {
      isLoading.value = true;

      // Verifica se banco está vazio -> sincroniza se necessário
      final vazio = await atividadeSyncService.estaVazio();
      if (vazio) {
        await atividadeSyncService.sincronizar();
      }

      // Carrega atividades do banco (join com equipamento)
      final listaComEquipamento = await atividadeService.buscarComEquipamento();
      atividades.assignAll(listaComEquipamento);

      // Atualiza contadores
      atualizarContadores();

      // Garante que a atividade em andamento seja buscada e setada corretamente
      await buscarAtividadeEmAndamento();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AtividadeController - carregarAtividades] ${erro.mensagem}',
          tag: 'AtividadeController', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao carregar atividades',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  void atualizarContadores() {
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
  }

  Future<void> buscarAtividadeEmAndamento() async {
    try {
      final atividade = await atividadeService.buscarAtividadeEmAndamento();
      atividadeEmAndamento.value = atividade;
    } catch (e, s) {
      AppLogger.e(
          '[AtividadeController - buscarAtividadeEmAndamento] Erro ao buscar atividade em andamento',
          tag: 'AtividadeController',
          error: e,
          stackTrace: s);
    }
  }

  Future<void> iniciarAtividade(AtividadeModel atividade) async {
    try {
      atividadeEmAndamento.value = atividade;
      await atividadeService.iniciarAtividade(atividade);

      // Atualiza o status na lista em memória também
      final index = atividades.indexWhere((a) => a.id == atividade.id);
      if (index != -1) {
        atividades[index] =
            atividade.copyWithStatus(StatusAtividade.emAndamento);
        atividades.refresh(); // 🔥 Notifica GetX para atualizar as telas

        // Atualiza a atividade em andamento também ✅
        atividadeEmAndamento.value =
            atividade.copyWithStatus(StatusAtividade.emAndamento);

        // Atualiza os contadores também ✅
        atualizarContadores();
      }
    } catch (e, s) {
      atividadeEmAndamento.value = null;
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AtividadeController - iniciarAtividade] ${erro.mensagem}',
          tag: 'AtividadeController', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao iniciar atividade',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> sincronizarAtividades() async {
    try {
      isLoading.value = true;
      await atividadeSyncService.sincronizar();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AtividadeController - sincronizarAtividades] ${erro.mensagem}',
          tag: 'AtividadeController',
          error: e,
          stackTrace: s);
      Get.snackbar('Erro', 'Erro ao sincronizar atividades',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> finalizarAtividade(AtividadeModel atividade) async {
    try {
      await atividadeService.finalizarAtividade(atividade);
      atividadeEmAndamento.value = null;
      atividades.refresh();
      atualizarContadores();
      Get.snackbar('Sucesso', 'Atividade finalizada com sucesso',
          backgroundColor: Colors.green, colorText: Colors.white);

      Get.offAllNamed(Routes.home);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AtividadeController - finalizarAtividade] ${erro.mensagem}',
          tag: 'AtividadeController', error: e, stackTrace: s);
    }
  }
}


// TODO: verificar por que quando a atividade foi finalizada, a tela home nao atualizou os contadores e o proprio status da atividade

