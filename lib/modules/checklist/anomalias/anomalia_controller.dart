// anomalia_controller.dart

import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/domain/dto/anomalia/anomalia_table_dto.dart';
import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/defeito_table_dto.dart';
import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/equipamento_table_dto.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/modules/checklist/checklist_service.dart';

class AnomaliaController extends GetxController {
  final ChecklistService checklistService;
  final AtividadeController atividadeController;

  AnomaliaController({
    required this.checklistService,
    required this.atividadeController,
  });

  final equipamentos = <EquipamentoTableDto>[].obs;
  final defeitos = <DefeitoTableDto>[].obs;
  final equipamentoSelecionado = Rxn<EquipamentoTableDto>();

  final _anomalias = <String, List<AnomaliaTableDto>>{}.obs;

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

  //* Carrega os equipamentos para a subestação selecionada
  Future<void> carregarEquipamentos() async {
    try {
      final sub = atividadeController.atividadeEmAndamento.value?.subestacao;
      if (sub == null) throw Exception('Subestação não encontrada.');
      AppLogger.d(
          '[AnomaliaController] Buscando equipamentos para subestação: $sub');
      final lista = await checklistService.buscarEquipamentos(sub);
      equipamentos.assignAll(lista);
    } catch (e, s) {
      AppLogger.e('[AnomaliaController] Erro ao carregar equipamentos',
          error: e, stackTrace: s);
    }
  }

  //* Carrega os defeitos para o equipamento selecionado
  Future<void> carregarDefeitos(EquipamentoTableDto equipamento) async {
    try {
      AppLogger.d(
          '[AnomaliaController] Buscando defeitos para equipamento ID: ${equipamento.uuid} (${equipamento.nome})');
      final lista = await checklistService.buscarDefeitos(equipamento);
      defeitos.assignAll(lista);

      if (lista.isEmpty) {
        AppLogger.w(
            '[AnomaliaController] Nenhum defeito encontrado no banco para equipamento ${equipamento.nome}');
      } else {
        AppLogger.d(
            '[AnomaliaController] ${lista.length} defeito(s) carregado(s) para equipamento ${equipamento.nome}');
      }
    } catch (e, s) {
      AppLogger.e('[AnomaliaController] Erro ao carregar defeitos',
          error: e, stackTrace: s);
    }
  }

  //* Salva a anomalia
  Future<void> salvarAnomalia(
      String perguntaId, AnomaliaTableDto anomalia) async {
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

  //* Busca as anomalias para a pergunta selecionada
  List<AnomaliaTableDto> buscarAnomalias(String perguntaId) {
    return _anomalias[perguntaId] ?? [];
  }
}
