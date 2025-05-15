// login_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    final senhaVisivel = false.obs;

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Matrícula'),
                  onChanged: controller.matricula.call,
                ),
                const SizedBox(height: 16),
                Obx(() => TextField(
                      obscureText: !senhaVisivel.value,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        suffixIcon: IconButton(
                          icon: Icon(senhaVisivel.value
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () =>
                              senhaVisivel.value = !senhaVisivel.value,
                        ),
                      ),
                      onChanged: controller.senha.call,
                    )),
                const SizedBox(height: 24),
                if (controller.erro.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      controller.erro.value,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ElevatedButton(
                  onPressed:
                      controller.carregando.value ? null : controller.login,
                  child: controller.carregando.value
                      ? const CircularProgressIndicator()
                      : const Text('Entrar'),
                ),
              ],
            )),
      ),
    );
  }
}
