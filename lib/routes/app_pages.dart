import 'package:get/get.dart';
import 'package:sympla_app/modules/home/home_binding.dart';
import 'package:sympla_app/modules/home/home_page.dart';
import 'package:sympla_app/modules/login/login_binding.dart';
import 'package:sympla_app/modules/login/login_page.dart';

class AppPages {
  static const initial = '/home';

  static final routes = [
    GetPage(
      name: '/home',
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    // Adicione outras rotas aqui
  ];
}
