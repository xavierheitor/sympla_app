// HomeBinding
import 'package:get/get.dart';
import 'package:sympla_app/core/services/sync/atividade_sync_service.dart';
import 'package:sympla_app/core/data/repositories/atividade_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/atividade_repository.dart';
import 'package:sympla_app/modules/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AtividadeRepository>(() => AtividadeRepositoryImpl(
          dio: Get.find(),
          db: Get.find(),
        ));

    Get.lazyPut(() => AtividadeSyncService(Get.find()));
    // Get.lazyPut(
    //   () => AtividadeController(atividadeSyncService: Get.find()),
    //   fenix: true,
    // );
    Get.lazyPut(() => HomeController(Get.find(), Get.find()), fenix: true);
  }
}
