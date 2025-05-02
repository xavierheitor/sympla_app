import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/modules/resumo_anomalias/resumo_anomalias_controller.dart';
import 'package:sympla_app/modules/resumo_anomalias/widgets/anomalia_form_widget.dart';

class ResumoAnomaliasPage extends StatelessWidget {
  const ResumoAnomaliasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResumoAnomaliasController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo de Anomalias'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              await controller.concluirAtividade();
              Get.snackbar('Sucesso', 'Atividade concluída com sucesso');
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.anomalias.isEmpty) {
          return const Center(child: Text('Nenhuma anomalia adicionada.'));
        }

        return ListView.builder(
          itemCount: controller.anomalias.length,
          itemBuilder: (context, index) {
            final anomalia = controller.anomalias[index];
            return ListTile(
              title: Text('Anomalia ID: ${anomalia.id}'),
              subtitle: Text('Equipamento ID: ${anomalia.equipamentoId}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_red_eye),
                    onPressed: () {
                      // Aqui você pode abrir um widget de visualização
                      Get.dialog(
                        AlertDialog(
                          title: const Text('Detalhes da Anomalia'),
                          content:
                              Text('Equipamento ID: ${anomalia.equipamentoId}\n'
                                  'Defeito ID: ${anomalia.defeitoId}\n'
                                  'Fase: ${anomalia.fase}\n'
                                  'Lado: ${anomalia.lado}'),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('Fechar'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Get.to(() => AnomaliaFormWidget(
                            perguntaId: anomalia.perguntaId ?? 0,
                            anomaliaExistente: anomalia,
                          ));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await controller.removerAnomalia(anomalia.id);
                      Get.snackbar('Removido', 'Anomalia removida com sucesso');
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AnomaliaFormWidget(
              perguntaId: -1)); // Passa -1 ou 0 se não houver pergunta
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
