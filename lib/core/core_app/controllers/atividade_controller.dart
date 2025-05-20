import 'package:get/get.dart';
import 'package:sympla_app/core/constants/etapas_atividade.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/core_app/services/atividade_service.dart';
import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';

class AtividadeController extends GetxController {
  final AtividadeService atividadeService;

  final RxList<AtividadeTableDto> atividades = <AtividadeTableDto>[].obs;
  final Rx<AtividadeTableDto?> atividadeEmAndamento =
      Rx<AtividadeTableDto?>(null);
  final Rx<EtapaAtividade?> etapaAtual = Rx<EtapaAtividade?>(null);
  final RxBool isLoading = false.obs;

  AtividadeController(
    this.atividadeService,
  );

  @override
  Future<void> onInit() async {
    super.onInit();
    await carregarAtividades();
  }

  Future<void> carregarAtividades() async {
    isLoading.value = true;
    try {
      final lista = await atividadeService.buscarComEquipamento();
      atividades.assignAll(lista);
      await _carregarEmAndamento();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sincronizarAtividades() async {
    isLoading.value = true;
    try {
      await atividadeService.sincronizar();
      await carregarAtividades();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> iniciarAtividade(AtividadeTableDto atividade) async {
    await atividadeService.iniciar(atividade);

    // Atualiza o status da atividade para refletir em tela imediatamente
    final atualizada = AtividadeTableDto(
      uuid: atividade.uuid,
      titulo: atividade.titulo,
      ordemServico: atividade.ordemServico,
      descricao: atividade.descricao,
      subestacao: atividade.subestacao,
      status: StatusAtividade.emAndamento,
      dataLimite: atividade.dataLimite,
      dataInicio: atividade.dataInicio,
      dataFim: atividade.dataFim,
      equipamentoId: atividade.equipamentoId,
      tipoAtividadeId: atividade.tipoAtividadeId,
      equipamento: atividade.equipamento,
      tipoAtividade: atividade.tipoAtividade,
    );
    atividadeEmAndamento.value = atualizada;

    // Substitui a atividade na lista principal
    final index = atividades.indexWhere((a) => a.uuid == atualizada.uuid);
    if (index != -1) {
      atividades[index] = atualizada;
      atividades.refresh(); // força atualização da lista
    }

    await executarAtividade(atualizada);
  }

  Future<void> finalizarAtividade(AtividadeTableDto atividade) async {
    await atividadeService.finalizar(atividade);
    atividadeEmAndamento.value = null;
    etapaAtual.value = null;
    await carregarAtividades();
    Get.offAllNamed(Routes.home); // ✅ redireciona para a home após finalizar
  }

Future<void> avancar() async {
    final atividade = atividadeEmAndamento.value;
    final atual = etapaAtual.value;
    if (atividade == null || atual == null) return;
    final proxima = await atividadeService.proximaEtapa(atividade, atual);

    // ✅ Corrigido: se a próxima for "finalizada", já finaliza de vez
    if (proxima == null || proxima == EtapaAtividade.finalizada) {
      etapaAtual.value = EtapaAtividade.finalizada;
      await finalizarAtividade(atividade);
    } else {
      etapaAtual.value = proxima;
      await executarAtividade(atividade);
    }
  }

  Future<void> executarAtividade(AtividadeTableDto atividade) async {
    etapaAtual.value ??= await atividadeService.etapaInicial(atividade);

    final etapa = etapaAtual.value!;
    final devePular = await atividadeService.desejaPularEtapa(etapa);

    if (devePular) {
      await avancar(); // já chama executarAtividade de novo
      return;
    }

    await atividadeService.navegarParaEtapa(etapa);
  }

  Future<void> _carregarEmAndamento() async {
    final atividade = await atividadeService.buscarAtividadeEmAndamento();
    if (atividade != null) {
      atividadeEmAndamento.value = atividade;
      etapaAtual.value = EtapaAtividade.apr;
    }
  }

  List<AtividadeTableDto> get outrasAtividades => atividades
      .where((a) => a.uuid != atividadeEmAndamento.value?.uuid)
      .toList();
}
