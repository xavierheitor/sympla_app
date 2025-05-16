import 'package:get/get.dart';
import 'package:sympla_app/core/constants/etapas_atividade.dart';
import 'package:sympla_app/core/core_app/services/atividade_service.dart';
import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';

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
    atividadeEmAndamento.value = atividade;
    await atividadeService.iniciar(atividade);
    await executarAtividade(atividade);
  }

  Future<void> finalizarAtividade(AtividadeTableDto atividade) async {
    await atividadeService.finalizar(atividade);
    atividadeEmAndamento.value = null;
    etapaAtual.value = null;
    await carregarAtividades();
  }

  Future<void> avancar() async {
    final atividade = atividadeEmAndamento.value;
    final atual = etapaAtual.value;
    if (atividade == null || atual == null) return;
    final proxima = await atividadeService.proximaEtapa(atividade, atual);
    if (proxima == null) {
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
