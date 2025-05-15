// HomeBinding
import 'package:get/get.dart';

import 'package:sympla_app/modules/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    //inicia o repositorio das atividades

    //inicia o controller da propria home
    Get.lazyPut(() => HomeController(Get.find(), Get.find()), fenix: true);
  }
}
