// lib/modules/atividade/atividade_controller.dart

import 'package:get/get.dart';
import 'package:sympla_app/core/constants/etapas_atividade.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/core_app/services/atividade_service.dart';
import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/core/sync/sync_manager.dart';

class AtividadeController extends GetxController {
  final AtividadeService atividadeService;

  final RxList<AtividadeTableDto> atividades = <AtividadeTableDto>[].obs;
  final Rx<AtividadeTableDto?> atividadeEmAndamento =
      Rx<AtividadeTableDto?>(null);
  final Rx<EtapaAtividade?> etapaAtual = Rx<EtapaAtividade?>(null);
  final RxBool isLoading = false.obs;

  AtividadeController(this.atividadeService);

  @override
  Future<void> onInit() async {
    super.onInit();
    await carregarAtividades();
  }

  /// 🚚 Carrega as atividades do banco com JOIN no equipamento
  Future<void> carregarAtividades() async {
    isLoading.value = true;
    try {
      final lista = await atividadeService.buscarAtividadesComEquipamento();
      atividades.assignAll(lista);
      await _carregarEmAndamento();
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔄 Sincroniza atividades e recarrega a lista
  Future<void> sincronizarAtividades() async {
    isLoading.value = true;
    try {
      await Get.find<SyncManager>().sincronizarModulo('atividade', force: true);
      await carregarAtividades();
    } finally {
      isLoading.value = false;
    }
  }

  /// ▶️ Inicia uma atividade e executa sua primeira etapa
  Future<void> iniciarAtividade(AtividadeTableDto atividade) async {
    await atividadeService.iniciar(atividade);

    final atualizada = atividade.copyWith(status: StatusAtividade.emAndamento);
    atividadeEmAndamento.value = atualizada;

    final index = atividades.indexWhere((a) => a.uuid == atualizada.uuid);
    if (index != -1) {
      atividades[index] = atualizada;
      atividades.refresh();
    }

    await executarAtividade(atualizada);
  }

  /// ⏹️ Finaliza a atividade atual e volta para a Home
  Future<void> finalizarAtividade(AtividadeTableDto atividade) async {
    await atividadeService.finalizar(atividade);
    atividadeEmAndamento.value = null;
    etapaAtual.value = null;
    await carregarAtividades();
    Get.offAllNamed(Routes.home);
  }

  /// ⏭️ Avança para a próxima etapa ou finaliza
  Future<void> avancar() async {
    final atividade = atividadeEmAndamento.value;
    final atual = etapaAtual.value;
    if (atividade == null || atual == null) return;

    final proxima = await atividadeService.proximaEtapa(atividade, atual);

    if (proxima == null || proxima == EtapaAtividade.finalizada) {
      etapaAtual.value = EtapaAtividade.finalizada;
      await finalizarAtividade(atividade);
    } else {
      etapaAtual.value = proxima;
      await executarAtividade(atividade);
    }
  }

  /// 🚀 Executa a etapa atual da atividade
  Future<void> executarAtividade(AtividadeTableDto atividade) async {
    etapaAtual.value ??= await atividadeService.etapaInicial(atividade);

    final etapa = etapaAtual.value!;
    final devePular = await atividadeService.desejaPularEtapa(etapa);

    if (devePular) {
      await avancar();
      return;
    }

    await atividadeService.executar(atividade, etapa);
  }

  /// 🔍 Carrega a atividade em andamento, se houver
  Future<void> _carregarEmAndamento() async {
    final atividade = await atividadeService.buscarAtividadeEmAndamento();
    if (atividade != null) {
      atividadeEmAndamento.value = atividade;
      etapaAtual.value = await atividadeService.etapaInicial(atividade);
    }
  }

  /// 🔗 Outras atividades diferentes da em andamento
  List<AtividadeTableDto> get outrasAtividades => atividades
      .where((a) => a.uuid != atividadeEmAndamento.value?.uuid)
      .toList();
}
