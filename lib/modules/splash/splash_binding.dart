import 'package:get/get.dart';
import 'package:sympla_app/core/domain/repositories/implementations/sync/apr_modelo_tipo_atividade_table_sync_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/sync/apr_pergunta_relacionamento_table_sync_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/sync/apr_question_table_sync_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/sync/apr_table_sync_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/sync/atividade_table_sync_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/sync/checklist_modelo_tipo_atividade_table_sync_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/sync/checklist_pergunta_relacionamento_table_sync_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/sync/checklist_pergunta_table_sync_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/sync/checklist_table_sync_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/sync/defeito_table_sync_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/sync/equipamento_table_sync_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/sync/grupo_defeito_equipamento_table_sync_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/sync/subgrupo_defeito_equipamento_table_sync_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/sync/tecnico_table_sync_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/sync/tipo_atividade_table_sync_impl.dart';
import 'package:sympla_app/core/sync/sync_manager.dart';
import 'package:sympla_app/modules/splash/splash_controller.dart';

/// Binding da tela de Splash.
///
/// Responsável por:
/// - Instanciar o `SyncManager`
/// - Registrar todos os repositórios sincronizáveis (módulos)
/// - Disponibilizar `SplashController` para a view
 
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Instancia o SyncManager
    final syncManager = SyncManager();

    // Registra os módulos de sincronização (ordem irrelevante)
    syncManager.registrar(AprPerguntaRelacionamentoTableSyncImpl(
      Get.find(),
      Get.find(),
    ));

    syncManager.registrar(AprQuestionTableSyncImpl(
      Get.find(),
      Get.find(),
    ));

    syncManager.registrar(AprTableSyncImpl(
      Get.find(),
      Get.find(),
    ));

    syncManager.registrar(TipoAtividadeTableSyncImpl(
      Get.find(),
      Get.find(),
    ));

    syncManager.registrar(ChecklistTableSyncImpl(
      Get.find(),
      Get.find(),
    ));

    syncManager.registrar(ChecklistPerguntaRelacionamentoTableSyncImpl(
      Get.find(),
      Get.find(),
    ));

    syncManager.registrar(ChecklistPerguntaTableSyncImpl(
      Get.find(),
      Get.find(),
    ));

    syncManager.registrar(DefeitoTableSyncImpl(
      Get.find(),
      Get.find(),
    ));

    syncManager.registrar(GrupoDefeitoEquipamentoTableSyncImpl(
      Get.find(),
      Get.find(),
    ));

    syncManager.registrar(SubgrupoDefeitoEquipamentoTableSyncImpl(
      Get.find(),
      Get.find(),
    ));

    syncManager.registrar(EquipamentoTableSyncImpl(
      Get.find(),
      Get.find(),
    ));

    syncManager.registrar(TecnicoTableSyncImpl(
      Get.find(),
      Get.find(),
    ));

    syncManager.registrar(AtividadeTableSyncImpl(
      Get.find(),
      Get.find(),
    ));
    // syncManager.registrar(OutroSyncImpl());

    syncManager.registrar(AprModeloTipoAtividadeTableSyncImpl(
      Get.find(),
      Get.find(),
    ));

    syncManager.registrar(ChecklistModeloTipoAtividadeTableSyncImpl(
      Get.find(),
      Get.find(),
    ));

    // Disponibiliza o SyncManager e o SplashController no container do GetX
    Get.put<SyncManager>(syncManager, permanent: true);
    Get.put(SplashController(
      syncManager: syncManager,
    ));
  }
}
