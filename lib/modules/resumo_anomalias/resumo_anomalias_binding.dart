import 'package:get/get.dart';
import 'package:sympla_app/core/data_old/repositories/checklist/anomalia_repository_impl.dart';
import 'package:sympla_app/core/data_old/repositories/checklist/defeito_repository_impl.dart';
import 'package:sympla_app/core/data_old/repositories/equipamento_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/checklist/anomalia_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/defeito_repository.dart';
import 'package:sympla_app/core/domain/repositories/equipamento_repository.dart';
import 'package:sympla_app/modules/resumo_anomalias/resumo_anomalia_service.dart';
import 'package:sympla_app/modules/resumo_anomalias/resumo_anomalias_controller.dart';

class ResumoAnomaliasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnomaliaRepository>(
        () => AnomaliaRepositoryImpl(db: Get.find()));

    Get.lazyPut<EquipamentoRepository>(
        () => EquipamentoRepositoryImpl(db: Get.find(), dio: Get.find()));

    Get.lazyPut<DefeitoRepository>(
        () => DefeitoRepositoryImpl(db: Get.find(), dio: Get.find()));

    Get.lazyPut<ResumoAnomaliasService>(() => ResumoAnomaliasService(
        anomaliaRepository: Get.find(),
        equipamentoRepository: Get.find(),
        defeitoRepository: Get.find()));

    Get.lazyPut<ResumoAnomaliasController>(() => ResumoAnomaliasController(
          service: Get.find(),
          atividadeController: Get.find(),
        ));
  }
}
