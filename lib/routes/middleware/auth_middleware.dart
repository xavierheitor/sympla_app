import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/session/session_manager.dart';
import 'package:sympla_app/core/constants/route_names.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final sessionManager = Get.find<SessionManager>();

    if (!sessionManager.estaLogado) {
      AppLogger.w(
          '🔐 Acesso negado à rota "$route". Redirecionando para login.',
          tag: 'AuthMiddleware');
      return const RouteSettings(name: Routes.login);
    }

    AppLogger.i('✅ Acesso autorizado à rota "$route"', tag: 'AuthMiddleware');
    return null;
  }
}
