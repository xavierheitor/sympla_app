import 'package:get/get.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/services/checklist_service.dart';
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
      final lista = await checklistService.buscarDefeitos(equipamento);
      defeitos.assignAll(lista);
    } catch (e, s) {
      AppLogger.e('[AnomaliaController] Erro ao carregar defeitos',
          error: e, stackTrace: s);
    }
  }
}
