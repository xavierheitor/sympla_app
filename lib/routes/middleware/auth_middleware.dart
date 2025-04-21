import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/session/session_manager.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final session = Get.find<SessionManager>();

    if (!session.estaLogado) {
      return const RouteSettings(name: '/login');
    }

    return null; // segue normalmente
  }
}
