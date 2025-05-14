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
          onPressed: () => Get.offAllNamed('/home'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              await controller.salvarRespostas();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.carregando) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.perguntas.length,
                itemBuilder: (context, index) {
                  final pergunta = controller.perguntas[index];
                  final resposta = controller.respostas[pergunta.uuid];
                  return PerguntaChecklistWidget(
                    pergunta: pergunta,
                    resposta: resposta,
                    onSelecionar: (r) =>
                        controller.registrarResposta(pergunta.uuid, r),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
