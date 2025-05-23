import 'package:get/get.dart';
import 'package:sympla_app/core/constants/etapas_atividade.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/core_app/services/atividade_etapa_service.dart';
import 'package:sympla_app/core/core_app/services/atividade_service.dart';
import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/core/sync/sync_manager.dart';

/// 🎯 Controller responsável por gerenciar o estado das atividades,
/// incluindo a lista de atividades disponíveis, a atividade em andamento,
/// a etapa atual e os fluxos de navegação.
///
/// 🔗 Este controller delega responsabilidades:
/// - Persistência e CRUD → `AtividadeService`
/// - Fluxo e etapas → `AtividadeEtapaService`
class AtividadeController extends GetxController {
  /// Service responsável pela persistência e dados das atividades
  final AtividadeService atividadeService;

  /// Service responsável pela lógica do fluxo das etapas da atividade
  final AtividadeEtapaService etapaService;

  /// 🔥 Lista de atividades carregadas (com dados do equipamento e tipo)
  final RxList<AtividadeTableDto> atividades = <AtividadeTableDto>[].obs;

  /// 🔥 A atividade que está atualmente em execução (pode ser nula)
  final Rx<AtividadeTableDto?> atividadeEmAndamento =
      Rx<AtividadeTableDto?>(null);

  /// 🔥 Etapa atual da atividade em andamento (pode ser nula)
  final Rx<EtapaAtividade?> etapaAtual = Rx<EtapaAtividade?>(null);

  /// 🔄 Estado de carregamento (para exibir loading na interface)
  final RxBool isLoading = false.obs;

  AtividadeController(this.atividadeService, this.etapaService);

  /// 🚀 Ao iniciar o controller, carrega a lista de atividades do banco
  @override
  Future<void> onInit() async {
    super.onInit();
    await carregarAtividades();
  }

  /// 🔄 Carrega as atividades do banco local com join no equipamento
  /// e também carrega a atividade que estiver em andamento, se houver.
  Future<void> carregarAtividades() async {
    isLoading.value = true;
    try {
      AppLogger.d('🌀 Carregando atividades do banco');
      final lista = await atividadeService.buscarAtividadesComEquipamento();
      atividades.assignAll(lista);
      await _carregarEmAndamento();
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔄 Sincroniza as atividades com a API e recarrega a lista local.
  Future<void> sincronizarAtividades() async {
    isLoading.value = true;
    try {
      AppLogger.d('🔄 Iniciando sincronização das atividades');
      await Get.find<SyncManager>().sincronizarModulo('atividade', force: true);
      await carregarAtividades();
    } finally {
      isLoading.value = false;
    }
  }

  /// ▶️ Inicia uma atividade, atualiza seu status no banco
  /// e começa o fluxo das etapas.
  Future<void> iniciarAtividade(AtividadeTableDto atividade) async {
    AppLogger.d('▶️ Iniciando atividade ${atividade.uuid}');
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

  /// ⏹️ Finaliza a atividade em andamento, reseta o estado
  /// e retorna para a Home.
  Future<void> finalizarAtividade(AtividadeTableDto atividade) async {
    AppLogger.d('⏹️ Finalizando atividade ${atividade.uuid}');
    await atividadeService.finalizar(atividade);
    atividadeEmAndamento.value = null;
    etapaAtual.value = null;
    await carregarAtividades();
    Get.offAllNamed(Routes.home);
  }

  /// ⏭️ Avança para a próxima etapa do fluxo da atividade atual.
  /// Se não houver próxima, finaliza a atividade.
  Future<void> avancar() async {
    final atividade = atividadeEmAndamento.value;
    final atual = etapaAtual.value;

    if (atividade == null || atual == null) {
      AppLogger.w('⚠️ Nenhuma atividade ou etapa atual para avançar');
      return;
    }

    AppLogger.d('⏭️ Avançando da etapa $atual', tag: 'AtividadeController');

    final proxima = await etapaService.proximaEtapa(atividade, atual);

    if (proxima == null || proxima == EtapaAtividade.finalizada) {
      AppLogger.d('✅ Fluxo concluído. Finalizando atividade.');
      etapaAtual.value = EtapaAtividade.finalizada;
      await finalizarAtividade(atividade);
    } else {
      AppLogger.d('➡️ Próxima etapa: $proxima');
      etapaAtual.value = proxima;
      await executarAtividade(atividade);
    }
  }

  /// 🚀 Executa a etapa atual da atividade.
  /// Se a etapa não estiver definida, calcula a etapa inicial.
  /// Verifica se deve pular a etapa, e em caso contrário, executa-a.
  Future<void> executarAtividade(AtividadeTableDto atividade) async {
    etapaAtual.value ??= await etapaService.etapaInicial(atividade);

    final etapa = etapaAtual.value!;
    AppLogger.d('🚀 Executando etapa $etapa', tag: 'AtividadeController');

    final devePular = await etapaService.desejaPularEtapa(etapa);

    if (devePular) {
      AppLogger.d('⏭️ Etapa $etapa foi pulada automaticamente');
      await avancar();
      return;
    }

    await etapaService.executar(atividade, etapa);
  }

  /// 🔍 Carrega a atividade que estiver em andamento (se houver)
  /// junto com sua etapa atual calculada.
  Future<void> _carregarEmAndamento() async {
    AppLogger.d('🔍 Verificando se há atividade em andamento');
    final atividade = await atividadeService.buscarAtividadeEmAndamento();
    if (atividade != null) {
      atividadeEmAndamento.value = atividade;
      etapaAtual.value = await etapaService.etapaInicial(atividade);
      AppLogger.d(
          '🔄 Atividade em andamento: ${atividade.uuid}, etapa: ${etapaAtual.value}');
    }
  }

  /// 🔗 Lista de atividades que não estão em andamento
  List<AtividadeTableDto> get outrasAtividades => atividades
      .where((a) => a.uuid != atividadeEmAndamento.value?.uuid)
      .toList();
}
