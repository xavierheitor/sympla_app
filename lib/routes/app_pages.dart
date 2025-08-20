import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/modules/apr/apr_binding.dart'; // TODO: renomear para apr_binding.dart
import 'package:sympla_app/modules/apr/apr_page.dart';
import 'package:sympla_app/modules/checklist/checklist_binding.dart';
import 'package:sympla_app/modules/checklist/checklist_page.dart';
import 'package:sympla_app/modules/home/home_binding.dart';
import 'package:sympla_app/modules/home/home_page.dart';
import 'package:sympla_app/modules/login/login_binding.dart';
import 'package:sympla_app/modules/login/login_page.dart';
import 'package:sympla_app/modules/mp_bb/mp_bb_form_binding.dart';
import 'package:sympla_app/modules/mp_bb/mp_bb_form_page.dart';
import 'package:sympla_app/modules/mp_dj/etapas/etapa_pressao_sf6_form_page.dart';
import 'package:sympla_app/modules/mp_dj/etapas/etapa_resistencia_contato_form_page.dart';
import 'package:sympla_app/modules/mp_dj/etapas/etapa_resistencia_isolamento_form_page.dart';
import 'package:sympla_app/modules/mp_dj/etapas/etapa_tempo_operacao_form_page.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_binding.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_page.dart';
import 'package:sympla_app/modules/resumo_anomalias/resumo_anomalias_binding.dart';
import 'package:sympla_app/modules/resumo_anomalias/resumo_anomalias_page.dart';
import 'package:sympla_app/modules/splash/erro_splash_page.dart';
import 'package:sympla_app/modules/splash/splash_binding.dart';
import 'package:sympla_app/modules/splash/splash_page.dart';
import 'package:sympla_app/modules/sync/sync_binding.dart';
import 'package:sympla_app/modules/sync/sync_status_page.dart';
import 'package:sympla_app/routes/middleware/auth_middleware.dart';

/// Declaração central de rotas da aplicação.
///
/// - `initial` define a rota inicial do app
/// - `routes` lista todas as páginas com seus bindings e middlewares
class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: HomePage.new,
      binding: HomeBinding(),
      // Protege a Home exigindo sessão autenticada
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.splash,
      page: SplashPage.new,
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.erroSplash,
      page: () => const ErroSplashPage(),
    ),
    GetPage(
      name: Routes.apr,
      page: AprPage.new,
      binding: AprBinding(),
    ),
    GetPage(
      name: Routes.checklist,
      page: ChecklistPage.new,
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

    //MPJD
    GetPage(
      name: Routes.mpDjForm,
      page: () => const MpDjFormPage(),
      binding: MpDjFormBinding(),
    ),
    GetPage(
      name: Routes.etapaResistenciaContato,
      page: () => const EtapaResistenciaContatoPage(),
      binding: MpDjFormBinding(),
    ),
    GetPage(
      name: Routes.etapaIsolamento,
      page: () => const EtapaResistenciaIsolamentoPage(),
      binding: MpDjFormBinding(),
    ),
    GetPage(
      name: Routes.etapaTempoOperacao,
      page: () => const EtapaTempoOperacaoPage(),
      binding: MpDjFormBinding(),
    ),
    GetPage(
      name: Routes.etapaPressaoSf6,
      page: () => const EtapaPressaoSf6Page(),
      binding: MpDjFormBinding(),
    ),

    // Sincronização
    GetPage(
      name: Routes.syncStatus,
      page: () => const SyncStatusPage(),
      binding: SyncBinding(),
      // A tela de status de sync também requer autenticação
      middlewares: [AuthMiddleware()],
    ),

    // Adicione outras rotas aqui
  ];
}
