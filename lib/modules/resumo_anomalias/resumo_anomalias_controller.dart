// resumo_anomalias_controller.dart
import 'package:get/get.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/modules/resumo_anomalias/resumo_anomalia_service.dart';
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

  final equipamentoSelecionado = Rxn<EquipamentoTableData>();

  @override
  void onInit() {
    super.onInit();
    AppLogger.d('[ResumoAnomaliasController] onInit chamado');
    carregarAnomalias();
    carregarEquipamentos();
  }

  Future<void> carregarAnomalias() async {
    final atividade = atividadeController.atividadeEmAndamento.value;
    AppLogger.d('[ResumoAnomaliasController] Carregando anomalias...');
    if (atividade == null) {
      AppLogger.w('[ResumoAnomaliasController] Nenhuma atividade em andamento');
      return;
    }

    try {
      final lista = await service.buscarAnomaliasPorAtividade(atividade.id);
      AppLogger.d(
          '[ResumoAnomaliasController] ${lista.length} anomalias encontradas para atividade ${atividade.id}');
      for (final a in lista) {
        AppLogger.d(
            '↳ Anomalia id=${a.id}, defeitoId=${a.defeitoId}, equipamentoId=${a.equipamentoId}');
      }
      anomalias.assignAll(lista);
    } catch (e, s) {
      AppLogger.e('[ResumoAnomaliasController] Erro ao carregar anomalias',
          error: e, stackTrace: s);
    }
  }

  Future<void> carregarEquipamentos() async {
    final sub = atividadeController.atividadeEmAndamento.value?.subestacao;
    AppLogger.d('[ResumoAnomaliasController] Carregando equipamentos...');
    if (sub == null) {
      AppLogger.w('[ResumoAnomaliasController] Subestação não encontrada.');
      return;
    }

    try {
      final lista = await service.buscarEquipamentos(sub);
      AppLogger.d(
          '[ResumoAnomaliasController] ${lista.length} equipamentos carregados da subestacao $sub');
      for (final e in lista) {
        AppLogger.d('↳ Equipamento: id=${e.id}, nome=${e.nome}');
      }
      equipamentos.assignAll(lista);

      // 👉 Seleciona o primeiro equipamento automaticamente
      if (lista.isNotEmpty) {
        equipamentoSelecionado.value = lista.first;
        await carregarDefeitos(lista.first);
      }
    } catch (e, s) {
      AppLogger.e('[ResumoAnomaliasController] Erro ao carregar equipamentos',
          error: e, stackTrace: s);
    }
  }

  Future<void> carregarDefeitos(EquipamentoTableData equipamento) async {
    AppLogger.d(
        '[ResumoAnomaliasController] Carregando defeitos para equipamento id=${equipamento.id} nome=${equipamento.nome}');
    try {
      final lista = await service.buscarDefeitos(equipamento);
      AppLogger.d(
          '[ResumoAnomaliasController] ${lista.length} defeitos encontrados');
      for (final d in lista) {
        AppLogger.d(
            '↳ Defeito: id=${d.id}, descricao=${d.descricao}, sap=${d.codigoSap}');
      }
      defeitos.assignAll(lista);
    } catch (e, s) {
      AppLogger.e('[ResumoAnomaliasController] Erro ao carregar defeitos',
          error: e, stackTrace: s);
    }
  }

  Future<void> salvarOuAtualizarAnomalia(
      AnomaliaTableCompanion anomalia) async {
    final isEdicao = anomalia.id.present;
    AppLogger.d(
        '[ResumoAnomaliasController] ${isEdicao ? 'Atualizando' : 'Salvando'} anomalia...');
    AppLogger.d(
        '[ResumoAnomaliasController] Dados: perguntaId=${anomalia.perguntaId.value}, defeitoId=${anomalia.defeitoId.value}, equipamentoId=${anomalia.equipamentoId.value}');

    try {
      if (isEdicao) {
        AppLogger.d(
            '[ResumoAnomaliasController] Atualizando anomalia ID: ${anomalia.id.value}');
        await service.atualizarAnomalia(anomalia);
      } else {
        await service.salvarAnomalia(anomalia);
        AppLogger.d('[ResumoAnomaliasController] Nova anomalia salva');
      }
      await carregarAnomalias();
    } catch (e, s) {
      AppLogger.e(
          '[ResumoAnomaliasController] Erro ao salvar/atualizar anomalia',
          error: e,
          stackTrace: s);
    }
  }

  Future<void> removerAnomalia(int id) async {
    AppLogger.d('[ResumoAnomaliasController] Removendo anomalia ID: $id');
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
      AppLogger.d(
          '[ResumoAnomaliasController] Concluindo etapa atual da atividade ID: ${atividade.id}');
      await atividadeController.avancar();
    } catch (e, s) {
      AppLogger.e(
          '[ResumoAnomaliasController] Erro ao concluir etapa e avançar',
          error: e,
          stackTrace: s);
    }
  }
}
