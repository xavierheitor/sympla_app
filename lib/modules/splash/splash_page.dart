import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/modules/splash/splash_controller.dart';

class SplashPage extends StatelessWidget {
  final controller = Get.find<SplashController>();

  SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
