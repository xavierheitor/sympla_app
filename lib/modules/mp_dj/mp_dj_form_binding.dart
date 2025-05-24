import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/domain/repositories/implementations/mpdj_repository_impl.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_controller.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_service.dart';

class MpDjFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MpdjRepositoryImpl(Get.find(), Get.find()));
    Get.lazyPut(() => MpDjFormService(repository: Get.find()));
    Get.lazyPut(() => MpDjFormController(
          service: Get.find(),
          atividadeController: Get.find<AtividadeController>(),
        ));
  }
}
