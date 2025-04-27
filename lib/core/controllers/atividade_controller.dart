import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/services/sync/atividade_sync_service.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/data/models/atividade_model.dart';

class AtividadeController extends GetxController {
  final AtividadeSyncService atividadeSyncService;

  final RxList<AtividadeModel> atividades = <AtividadeModel>[].obs;
  final RxBool isLoading = false.obs;

  final RxInt atividadesPendentes = 0.obs;
  final RxInt atividadesConcluidas = 0.obs;
  final RxInt atividadesCanceladas = 0.obs;
  final RxInt atividadesEmAndamento = 0.obs;

  final Rx<AtividadeModel?> atividadeEmAndamento = Rx<AtividadeModel?>(null);

  AtividadeController({required this.atividadeSyncService});

  @override
  Future<void> onInit() async {
    super.onInit();
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
      final listaComEquipamento =
          await atividadeSyncService.buscarComEquipamento();
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
      final atividade = await atividadeSyncService.buscarAtividadeEmAndamento();
      atividadeEmAndamento.value = atividade;
    } catch (e, s) {
      AppLogger.e(
          '[AtividadeController - buscarAtividadeEmAndamento] Erro ao buscar atividade em andamento',
          tag: 'AtividadeController',
          error: e,
          stackTrace: s);
    }
  }
}
