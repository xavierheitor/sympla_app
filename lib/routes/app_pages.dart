import 'package:get/get.dart';
import 'package:sympla_app/modules/home/home_binding.dart';
import 'package:sympla_app/modules/home/home_page.dart';

class AppPages {
  static const initial = '/home';

  static final routes = [
    GetPage(
      name: '/home',
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    // Adicione outras rotas aqui
  ];
}
