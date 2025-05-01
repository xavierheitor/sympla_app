import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/modules/checklist/checklist_controller.dart';
import 'package:sympla_app/modules/checklist/widgets/pergunta_checklist_widget.dart';

class ChecklistPage extends StatelessWidget {
  final controller = Get.find<ChecklistController>();

  ChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAllNamed(
                '/home'); // substitui toda a pilha e vai direto pra home
          },
        ),
      ),
      body: Obx(() {
        if (controller.carregando) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.perguntas.isEmpty) {
          return const Center(child: Text('Nenhuma pergunta disponível.'));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.perguntas.length,
                itemBuilder: (_, index) {
                  final pergunta = controller.perguntas[index];
                  final respostaSelecionada = controller.respostas[pergunta.id];

                  return PerguntaChecklistWidget(
                    pergunta: pergunta,
                    resposta: respostaSelecionada,
                    onSelecionar: (resposta) {
                      controller.registrarResposta(pergunta.id, resposta);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Salvar Respostas'),
                onPressed: () async {
                  await controller.salvarRespostas();
                  Get.snackbar('Sucesso', 'Respostas salvas com sucesso');
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
