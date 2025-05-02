// checklist_binding.dart
import 'package:get/get.dart';
import 'package:sympla_app/core/data/repositories/checklist/checklist_grupo_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/checklist/checklist_pergunta_relacionamento_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/checklist/checklist_pergunta_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/checklist/checklist_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/checklist/checklist_resposta_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/checklist/checklist_subgrupo_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/checklist/defeito_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/equipamento_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_grupo_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_pergunta_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_pergunta_relacionamento_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_resposta_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_subgrupo_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/defeito_repository.dart';
import 'package:sympla_app/core/domain/repositories/equipamento_repository.dart';
import 'package:sympla_app/core/services/checklist_service.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/modules/checklist/anomalia_controller.dart';
import 'package:sympla_app/modules/checklist/checklist_controller.dart';

class ChecklistBinding extends Bindings {
  @override
  void dependencies() {
    final db = Get.find<AppDatabase>();
    final dio = Get.find<DioClient>();

    Get.lazyPut<ChecklistRepository>(
        () => ChecklistRepositoryImpl(dio: dio, db: db));
    Get.lazyPut<ChecklistGrupoRepository>(
        () => ChecklistGrupoRepositoryImpl(dio: dio, db: db));
    Get.lazyPut<ChecklistSubgrupoRepository>(
        () => ChecklistSubgrupoRepositoryImpl(dio: dio, db: db));
    Get.lazyPut<ChecklistPerguntaRepository>(
        () => ChecklistPerguntaRepositoryImpl(dio: dio, db: db));
    Get.lazyPut<ChecklistRespostaRepository>(
        () => ChecklistRespostaRepositoryImpl(db: db));
    Get.lazyPut<ChecklistPerguntaRelacionamentoRepository>(
        () => ChecklistPerguntaRelacionamentoRepositoryImpl(dio: dio, db: db));
    Get.lazyPut<EquipamentoRepository>(
        () => EquipamentoRepositoryImpl(dio: dio, db: db));
    Get.lazyPut<DefeitoRepository>(
        () => DefeitoRepositoryImpl(dio: dio, db: db));

    Get.lazyPut(() => ChecklistService(
          checklistRepository: Get.find(),
          grupoRepository: Get.find(),
          subgrupoRepository: Get.find(),
          perguntaRepository: Get.find(),
          respostaRepository: Get.find(),
          relacionamentoRepository: Get.find(),
          equipamentoRepository: Get.find(),
          defeitoRepository: Get.find(),
        ));

    Get.lazyPut(() => ChecklistController(
          checklistService: Get.find(),
          atividadeController: Get.find(),
        ));

    Get.lazyPut(() => AnomaliaController(
          checklistService: Get.find(),
          atividadeController: Get.find(),
        ));
  }
}
