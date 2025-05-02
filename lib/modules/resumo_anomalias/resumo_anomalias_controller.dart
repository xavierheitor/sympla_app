import 'package:get/get.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/services/resumo_anomalia_service.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class ResumoAnomaliasController extends GetxController {
  final ResumoAnomaliasService service;
  final AtividadeController atividadeController;

  ResumoAnomaliasController({
    required this.service,
    required this.atividadeController,
  });

  final anomalias = <AnomaliaTableData>[].obs;
  final equipamentos = <EquipamentoTableData>[].obs;
  final defeitos = <DefeitoTableData>[].obs;

  @override
  void onInit() {
    super.onInit();
    carregarAnomalias();
  }

  Future<void> carregarAnomalias() async {
    final atividade = atividadeController.atividadeEmAndamento.value;
    if (atividade == null) {
      AppLogger.w('[ResumoAnomaliasController] Nenhuma atividade em andamento');
      return;
    }

    try {
      final lista = await service.buscarAnomaliasPorAtividade(atividade.id);
      anomalias.assignAll(lista);
    } catch (e, s) {
      AppLogger.e('[ResumoAnomaliasController] Erro ao carregar anomalias',
          error: e, stackTrace: s);
    }
  }

  Future<void> carregarEquipamentos() async {
    final atividade = atividadeController.atividadeEmAndamento.value;
    if (atividade == null) return;
    try {
      final lista = await service.buscarEquipamentos(atividade.subestacao);
      equipamentos.assignAll(lista);
    } catch (e, s) {
      AppLogger.e('[ResumoAnomaliasController] Erro ao carregar equipamentos',
          error: e, stackTrace: s);
    }
  }

  Future<void> carregarDefeitos(EquipamentoTableData equipamento) async {
    try {
      final lista = await service.buscarDefeitos(equipamento);
      defeitos.assignAll(lista);
    } catch (e, s) {
      AppLogger.e('[ResumoAnomaliasController] Erro ao carregar defeitos',
          error: e, stackTrace: s);
    }
  }

  Future<void> salvarOuAtualizarAnomalia(
      AnomaliaTableCompanion anomalia) async {
    try {
      if (anomalia.id.present) {
        await service.atualizarAnomalia(anomalia);
      } else {
        await service.salvarAnomalia(anomalia);
      }
      await carregarAnomalias();
    } catch (e, s) {
      AppLogger.e('[ResumoAnomaliasController] Erro ao salvar anomalia',
          error: e, stackTrace: s);
    }
  }

  Future<void> removerAnomalia(int id) async {
    try {
      await service.removerAnomalia(id);
      anomalias.removeWhere((a) => a.id == id);
      AppLogger.d(
          '[ResumoAnomaliasController] Anomalia $id removida com sucesso');
    } catch (e, s) {
      AppLogger.e('[ResumoAnomaliasController] Erro ao remover anomalia',
          error: e, stackTrace: s);
    }
  }

  Future<void> concluirAtividade() async {
    final atividade = atividadeController.atividadeEmAndamento.value;
    if (atividade == null) {
      AppLogger.w(
          '[ResumoAnomaliasController] Nenhuma atividade para concluir');
      return;
    }

    try {
      await atividadeController.finalizarAtividade(atividade);
      Get.offAllNamed('/home');
    } catch (e, s) {
      AppLogger.e('[ResumoAnomaliasController] Erro ao concluir atividade',
          error: e, stackTrace: s);
    }
  }
}
