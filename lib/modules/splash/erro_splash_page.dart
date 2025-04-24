import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';

class ErroSplashPage extends StatelessWidget {
  const ErroSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Erro de Sincronização')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Não foi possível sincronizar os dados do aplicativo.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.splash),
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
