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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.atividades.isEmpty) {
          return const Center(child: Text('Nenhuma atividade encontrada'));
        }

        return ListView.builder(
          itemCount: controller.atividades.length,
          itemBuilder: (context, index) {
            final atividade = controller.atividades[index];
            return ListTile(
              title: Text(atividade.titulo),
              subtitle: Text('Subestação: ${atividade.subestacao}'),
            );
          },
        );
      }),
    );
  }
}
