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
      ),
      body: Obx(() {
        if (controller.carregando) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.perguntasPorGrupoSubgrupo.isEmpty) {
          return const Center(child: Text('Nenhuma pergunta disponível.'));
        }

        return Column(
          children: [
            Expanded(
              child: ListView(
                children:
                    controller.perguntasPorGrupoSubgrupo.entries.map((entry) {
                  final grupoId = entry.key.grupoId;
                  final subgrupoId = entry.key.subgrupoId;
                  final perguntas = entry.value;

                  final respondidas = perguntas
                      .where((p) => controller.respostas.containsKey(p.id))
                      .length;

                  final corTile = respondidas == perguntas.length
                      ? Colors.green.shade100
                      : respondidas == 0
                          ? Colors.white
                          : Colors.red.shade100;

                  return Container(
                    color: corTile,
                    child: ExpansionTile(
                      title: Text('Grupo $grupoId > Subgrupo $subgrupoId'),
                      children: perguntas.map((pergunta) {
                        final resposta = controller.respostas[pergunta.id];
                        return PerguntaChecklistWidget(
                          pergunta: pergunta,
                          resposta: resposta,
                          onSelecionar: (r) =>
                              controller.registrarResposta(pergunta.id, r),
                        );
                      }).toList(),
                    ),
                  );
                }).toList(),
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
