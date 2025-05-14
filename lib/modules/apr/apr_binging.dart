import 'package:get/get.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/apr_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/tecnico_repository.dart';
import 'package:sympla_app/core/domain/repositories/implementations/apr_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/implementations/tecnico_repository_impl.dart';
import 'package:sympla_app/modules/apr/apr_controller.dart';
import 'package:sympla_app/modules/apr/apr_service.dart';

class AprBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AprRepository>(() => AprRepositoryImpl(
          Get.find(),
          Get.find(),
        ));
    Get.lazyPut<TecnicoRepository>(() => TecnicoRepositoryImpl(
          Get.find(),
          Get.find(),
        ));

    Get.lazyPut(() => AprService(
          aprRepository: Get.find(),
          tecnicoRepository: Get.find(),
        ));

    Get.lazyPut(() => AprController(
          aprService: Get.find(),
          atividadeController: Get.find(),
        ));
  }
}
