import 'package:get/get.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/mpbb_repository.dart';
import 'package:sympla_app/core/domain/repositories/implementations/mpbb_repository_impl.dart';
import 'package:sympla_app/modules/mp_bb/mp_bb_form_controller.dart';
import 'package:sympla_app/modules/mp_bb/mp_bb_form_service.dart';


class MpBbFormBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<MpbbRepository>(() => MpbbRepositoryImpl(
          Get.find(),
          Get.find(),
        ));

    Get.lazyPut(() => MpBbFormService(
          mpbbRepository: Get.find(),
        ));

    Get.lazyPut(() => MpBbFormController(
          service: Get.find(),
        ));
  }
}
