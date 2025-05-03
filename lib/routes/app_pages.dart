import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/modules/apr/apr_binging.dart';
import 'package:sympla_app/modules/apr/apr_page.dart';
import 'package:sympla_app/modules/checklist/checklist_binding.dart';
import 'package:sympla_app/modules/checklist/checklist_page.dart';
import 'package:sympla_app/modules/home/home_binding.dart';
import 'package:sympla_app/modules/home/home_page.dart';
import 'package:sympla_app/modules/login/login_binding.dart';
import 'package:sympla_app/modules/login/login_page.dart';
import 'package:sympla_app/modules/mp_bb/mp_bb_form_binding.dart';
import 'package:sympla_app/modules/mp_bb/mp_bb_form_page.dart';
import 'package:sympla_app/modules/resumo_anomalias/resumo_anomalias_binding.dart';
import 'package:sympla_app/modules/resumo_anomalias/resumo_anomalias_page.dart';
import 'package:sympla_app/modules/splash/erro_splash_page.dart';
import 'package:sympla_app/modules/splash/splash_binding.dart';
import 'package:sympla_app/modules/splash/splash_page.dart';
import 'package:sympla_app/routes/middleware/auth_middleware.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.erroSplash,
      page: () => const ErroSplashPage(),
    ),
    GetPage(
      name: Routes.apr,
      page: () => AprPage(),
      binding: AprBinding(),
    ),
    GetPage(
      name: Routes.checklist,
      page: () => ChecklistPage(),
      binding: ChecklistBinding(),
    ),
    GetPage(
      name: Routes.resumoAnomalias,
      page: () => const ResumoAnomaliasPage(),
      binding: ResumoAnomaliasBinding(),
    ),
    GetPage(
      name: Routes.mpBbForm,
      page: () => const MpBbFormPage(),
      binding: MpBbFormBinding(),
    ),
    // Adicione outras rotas aqui
  ];
}
