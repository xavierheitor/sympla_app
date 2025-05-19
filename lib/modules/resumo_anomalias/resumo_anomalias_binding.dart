import 'package:get/get.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/defeito_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/equipamento_repository.dart';
import 'package:sympla_app/core/domain/repositories/implementations/defeito_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/equipamento_repository_impl.dart';
import 'package:sympla_app/modules/checklist/anomalia_controller.dart';
import 'package:sympla_app/modules/resumo_anomalias/resumo_anomalia_service.dart';
import 'package:sympla_app/modules/resumo_anomalias/resumo_anomalias_controller.dart';

class ResumoAnomaliasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EquipamentoRepository>(() => EquipamentoRepositoryImpl(
          Get.find(),
          Get.find(),
        ));

    Get.lazyPut<DefeitoRepository>(() => DefeitoRepositoryImpl(
          Get.find(),
          Get.find(),
        ));

    Get.lazyPut<ResumoAnomaliasService>(() => ResumoAnomaliasService(
          anomaliaRepository: Get.find(),
          equipamentoRepository: Get.find(),
          defeitoRepository: Get.find(),
        ));

    Get.lazyPut<ResumoAnomaliasController>(() => ResumoAnomaliasController(
          service: Get.find(),
        ));

    Get.lazyPut(
      () => AnomaliaController(
        checklistService: Get.find(),
        atividadeController: Get.find(),
      ),
    );
  }
}
