import 'package:get/get.dart';

import 'package:sympla_app/modules/mp_dj/mp_dj_form_controller.dart';


class MpDjFormBinding extends Bindings {
  @override
  void dependencies() {


    // Controller
    Get.lazyPut(() => MpDjFormController(
          service: Get.find(),
          atividadeController: Get.find(),
        ));
  }
}
