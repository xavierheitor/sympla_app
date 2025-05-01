import 'package:get/get.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
import 'package:sympla_app/core/services/checklist_service.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/resposta_checklist_converter.dart';
import 'package:drift/drift.dart' as d;

class ChecklistController extends GetxController {
  final ChecklistService checklistService;
  final AtividadeController atividadeController;

  ChecklistController({
    required this.checklistService,
    required this.atividadeController,
  });

  final _perguntas = <ChecklistPerguntaTableData>[].obs;
  final _respostas = <int, RespostaChecklist>{}.obs;
  final _carregando = false.obs;

  List<ChecklistPerguntaTableData> get perguntas => _perguntas;
  Map<int, RespostaChecklist> get respostas => _respostas;
  bool get carregando => _carregando.value;

  @override
  void onInit() {
    super.onInit();
    carregarChecklist();
  }

  Future<void> carregarChecklist() async {
    try {
      _carregando.value = true;
      final atividade = atividadeController.atividadeEmAndamento;
      if (atividade.value == null) {
        throw Exception('Nenhuma atividade em andamento.');
      }
      final checklist = await checklistService
          .buscarChecklistDaAtividade(atividade.value!.id);
      final perguntasRelacionadas =
          await checklistService.buscarPerguntasRelacionadas(checklist.id);
      _perguntas.assignAll(perguntasRelacionadas);
    } catch (e) {
      rethrow;
    } finally {
      _carregando.value = false;
    }
  }

  void registrarResposta(int perguntaId, RespostaChecklist resposta) {
    _respostas[perguntaId] = resposta;
  }

  Future<void> salvarRespostas() async {
    final atividade = atividadeController.atividadeEmAndamento;
    if (atividade.value == null) return;

    final lista = _respostas.entries.map((entry) {
      return ChecklistRespostaTableCompanion(
        perguntaId: d.Value(entry.key),
        atividadeId: d.Value(atividade.value?.id ?? 0),
        resposta: d.Value(entry.value),
      );
    }).toList();

    await checklistService.salvarRespostas(lista);
  }
}
