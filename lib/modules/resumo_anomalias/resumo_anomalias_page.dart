import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';

class ResumoAnomaliasPage extends StatelessWidget {
  const ResumoAnomaliasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.offAllNamed(Routes.home),
          child: const Text('Voltar para a tela inicial'),
        ),
      ),
    );
  }
}
