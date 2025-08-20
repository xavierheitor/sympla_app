// checklist_binding.dart
import 'package:get/get.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/anomalia_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/atividade_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/checklist_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/defeito_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/equipamento_repository.dart';
import 'package:sympla_app/core/domain/repositories/implementations/anomalia_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/atividade_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/checklist_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/defeito_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/equipamento_repository_impl.dart';
import 'package:sympla_app/modules/checklist/checklist_service.dart';
import 'package:sympla_app/modules/checklist/anomalias/anomalia_controller.dart';
import 'package:sympla_app/modules/checklist/checklist_controller.dart';

class ChecklistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChecklistRepository>(() => ChecklistRepositoryImpl(
          Get.find(),
          Get.find(),
        ));
    Get.lazyPut<AtividadeRepository>(() => AtividadeRepositoryImpl(
          Get.find(),
          Get.find(),
        ));
    Get.lazyPut<EquipamentoRepository>(() => EquipamentoRepositoryImpl(
          Get.find(),
          Get.find(),
        ));

    Get.lazyPut<DefeitoRepository>(() => DefeitoRepositoryImpl(
          Get.find(),
          Get.find(),
        ));

    Get.lazyPut<AnomaliaRepository>(() => AnomaliaRepositoryImpl(
          Get.find(),
        ));

    Get.lazyPut(() => ChecklistService(
          checklistRepository: Get.find(),
          atividadeRepository: Get.find(),
          equipamentoRepository: Get.find(),
          defeitoRepository: Get.find(),
          anomaliaRepository: Get.find(),
          session: Get.find(),
        ));

    Get.lazyPut(() => ChecklistController(
          service: Get.find(),
          atividadeController: Get.find(),
        ));

    Get.lazyPut(
      () =>
      AnomaliaController(
        checklistService: Get.find(),
        atividadeController: Get.find(),
      ),
    );
  }
}
