import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';

class ChecklistPage extends StatelessWidget {
  const ChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist'),
      ),
      body: Column(
        children: [
          const Text('Checklist'),
          ElevatedButton(
            onPressed: () {
              Get.offAllNamed(Routes.home);
            },
            child: const Text('Ir para home'),
          )
        ],
      ),
    );
  }
}
