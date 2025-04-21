import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  final controller = Get.find<HomeController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sympla Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: controller.sair,
          )
        ],
      ),
      body: Center(
        child: Text('Bem-vindo, ${controller.nomeUsuario}!'),
      ),
    );
  }
}
