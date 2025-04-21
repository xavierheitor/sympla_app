import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  final controller = Get.find<HomeController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sympla Home')),
      body: const Center(child: Text('Bem-vindo ao Sympla App')),
    );
  }
}
