import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/session/session_manager.dart';

class AuthGuardMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final sessionManager = Get.find<SessionManager>();

    if (!sessionManager.estaLogado) {
      AppLogger.w('🔐 Rota "$route" bloqueada: usuário não está logado');
      return const RouteSettings(name: Routes.login);
    }

    AppLogger.i('✅ Rota "$route" permitida para usuário logado');
    return null; // Libera o acesso
  }
}
