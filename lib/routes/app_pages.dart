import 'package:get/get.dart';
import 'package:sympla_app/modules/home/home_binding.dart';
import 'package:sympla_app/modules/home/home_page.dart';
import 'package:sympla_app/modules/login/login_binding.dart';
import 'package:sympla_app/modules/login/login_page.dart';
import 'package:sympla_app/modules/splash/splash_binding.dart';
import 'package:sympla_app/modules/splash/splash_page.dart';
import 'package:sympla_app/routes/middleware/auth_middleware.dart';

class AppPages {
  static const initial = '/home';

  static final routes = [
    GetPage(
      name: '/home',
      page: () => HomePage(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/splash',
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    // Adicione outras rotas aqui
  ];
}
