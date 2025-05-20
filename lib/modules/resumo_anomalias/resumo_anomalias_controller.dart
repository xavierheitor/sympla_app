// resumo_anomalias_controller.dart
import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/domain/dto/anomalia/anomalia_table_dto.dart';
import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/defeito_table_dto.dart';
import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/equipamento_table_dto.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/modules/resumo_anomalias/resumo_anomalia_service.dart';

class ResumoAnomaliasController extends GetxController {
  final ResumoAnomaliasService service;

  ResumoAnomaliasController({
    required this.service,
  });

  final anomalias = <AnomaliaTableDto>[].obs;
  final equipamentos = <EquipamentoTableDto>[].obs;
  final defeitos = <DefeitoTableDto>[].obs;

  final equipamentoSelecionado = Rxn<EquipamentoTableDto>();

  @override
  void onInit() {
    super.onInit();
    AppLogger.d('[ResumoAnomaliasController] onInit chamado');
    carregarAnomalias();
    carregarEquipamentos();
  }

//carrega as anomalias ja salvar no banco de dados
  Future<void> carregarAnomalias() async {
    final atividade =
        Get.find<AtividadeController>().atividadeEmAndamento.value;
    AppLogger.d('[ResumoAnomaliasController] Carregando anomalias...');
    if (atividade == null) {
      AppLogger.w('[ResumoAnomaliasController] Nenhuma atividade em andamento');
      return;
    }

    try {
      //carrega as anomalias da atividade
      final lista = await service.buscarAnomaliasPorAtividade(atividade.uuid);
      AppLogger.d(
          '[ResumoAnomaliasController] ${lista.length} anomalias encontradas para atividade ${atividade.uuid}');
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
    final sub =
        Get.find<AtividadeController>().atividadeEmAndamento.value?.subestacao;
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
        AppLogger.d('↳ Equipamento: id=${e.uuid}, nome=${e.nome}');
      }
      equipamentos.assignAll(lista);

      // // 👉 Seleciona o primeiro equipamento automaticamente
      // if (lista.isNotEmpty) {
      //   equipamentoSelecionado.value = lista.first;
      //   await carregarDefeitos(lista.first);
      // }
    } catch (e, s) {
      AppLogger.e('[ResumoAnomaliasController] Erro ao carregar equipamentos',
          error: e, stackTrace: s);
    }
  }

  Future<void> carregarDefeitos(EquipamentoTableDto equipamento) async {
    AppLogger.d(
        '[ResumoAnomaliasController] Carregando defeitos para equipamento id=${equipamento.uuid} nome=${equipamento.nome}');
    try {
      final lista = await service.buscarDefeitos(equipamento);
      AppLogger.d(
          '[ResumoAnomaliasController] ${lista.length} defeitos encontrados');
      for (final d in lista) {
        AppLogger.d(
            '↳ Defeito: id=${d.uuid}, descricao=${d.descricao}, sap=${d.codigoSap}');
      }
      defeitos.assignAll(lista);
    } catch (e, s) {
      AppLogger.e('[ResumoAnomaliasController] Erro ao carregar defeitos',
          error: e, stackTrace: s);
    }
  }

  Future<void> salvarOuAtualizarAnomalia(AnomaliaTableDto anomalia) async {
    final isEdicao = anomalia.id != null;
    AppLogger.d(
        '[ResumoAnomaliasController] ${isEdicao ? 'Atualizando' : 'Salvando'} anomalia...');

    try {
      if (isEdicao) {
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

  //conclui a etapa atual da atividade
  Future<void> concluirEtapa() async {
    final atividade =
        Get.find<AtividadeController>().atividadeEmAndamento.value;
    if (atividade == null) {
      AppLogger.w(
          '[ResumoAnomaliasController] Nenhuma atividade para concluir');
      return;
    }

    try {
      AppLogger.d(
          '[ResumoAnomaliasController] Concluindo etapa atual da atividade ID: ${atividade.uuid}');
      //avanca para a proxima etapa
      await Get.find<AtividadeController>().avancar();
    } catch (e, s) {
      AppLogger.e(
          '[ResumoAnomaliasController] Erro ao concluir etapa e avançar',
          error: e,
          stackTrace: s);
    }
  }
}
