// anomalia_controller.dart

import 'package:get/get.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/modules/checklist/checklist_service.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class AnomaliaController extends GetxController {
  final ChecklistService checklistService;
  final AtividadeController atividadeController;

  AnomaliaController({
    required this.checklistService,
    required this.atividadeController,
  });

  final equipamentos = <EquipamentoTableData>[].obs;
  final defeitos = <DefeitoTableData>[].obs;
  final equipamentoSelecionado = Rxn<EquipamentoTableData>();

  final _anomalias = <int, List<AnomaliaTableCompanion>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    carregarEquipamentos();
    ever(equipamentoSelecionado, (equipamento) {
      if (equipamento != null) {
        carregarDefeitos(equipamento);
      } else {
        defeitos.clear();
      }
    });
  }

  Future<void> carregarEquipamentos() async {
    try {
      final sub = atividadeController.atividadeEmAndamento.value?.subestacao;
      if (sub == null) throw Exception('Subestação não encontrada.');
      final lista = await checklistService.buscarEquipamentos(sub);
      equipamentos.assignAll(lista);
    } catch (e, s) {
      AppLogger.e('[AnomaliaController] Erro ao carregar equipamentos',
          error: e, stackTrace: s);
    }
  }

  Future<void> carregarDefeitos(EquipamentoTableData equipamento) async {
    try {
      AppLogger.d(
          '[AnomaliaController] Buscando defeitos para equipamento ID: ${equipamento.id} (${equipamento.nome})');
      final lista = await checklistService.buscarDefeitos(equipamento);
      defeitos.assignAll(lista);

      if (lista.isEmpty) {
        AppLogger.w(
            '[AnomaliaController] Nenhum defeito encontrado no banco para equipamento ID ${equipamento.id}');
      } else {
        AppLogger.d(
            '[AnomaliaController] ${lista.length} defeito(s) carregado(s) para equipamento ID ${equipamento.id}');
      }
    } catch (e, s) {
      AppLogger.e('[AnomaliaController] Erro ao carregar defeitos',
          error: e, stackTrace: s);
    }
  }

  Future<void> salvarAnomalia(
      int perguntaId, AnomaliaTableCompanion anomalia) async {
    final lista = _anomalias[perguntaId] ?? [];
    lista.add(anomalia);
    _anomalias[perguntaId] = lista;
    try {
      await checklistService.salvarAnomalia(anomalia);
    } catch (e, s) {
      AppLogger.e('[AnomaliaController] Erro ao salvar anomalia',
          error: e, stackTrace: s);
    }
    AppLogger.d(
        '[AnomaliaController] Anomalia salva (Companion) para pergunta $perguntaId');
  }

  List<AnomaliaTableCompanion> buscarAnomalias(int perguntaId) {
    return _anomalias[perguntaId] ?? [];
  }
}
