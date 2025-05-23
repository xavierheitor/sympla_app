import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/modules/resumo_anomalias/resumo_anomalias_controller.dart';
import 'package:sympla_app/modules/resumo_anomalias/widgets/anomalia_detalhes_widget.dart';
import 'package:sympla_app/modules/resumo_anomalias/widgets/anomalia_form_widget.dart';

class ResumoAnomaliasPage extends StatelessWidget {
  const ResumoAnomaliasPage({super.key});

  @override
  Widget build(BuildContext context) {
    //controller do resumo de anomalias
    final controller = Get.find<ResumoAnomaliasController>();
    AppLogger.d('[ResumoAnomaliasPage] Página construída');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo de Anomalias'),
        actions: [
          //botao de concluir etapa
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              AppLogger.d(
                  '[ResumoAnomaliasPage] Botão concluir atividade pressionado');
              await controller.concluirEtapa();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.anomalias.isEmpty) {
          AppLogger.d('[ResumoAnomaliasPage] Nenhuma anomalia cadastrada');
          return const Center(child: Text('Nenhuma anomalia adicionada.'));
        }

        AppLogger.d(
            '[ResumoAnomaliasPage] Renderizando ${controller.anomalias.length} anomalias');

        return ListView.builder(
          itemCount: controller.anomalias.length,
          itemBuilder: (context, index) {
            //pega a anomalia
            final anomalia = controller.anomalias[index];
            //pega o equipamento

            return ListTile(
// E use diretamente os campos opcionais vindos do DTO:
              title: Text(anomalia.codigoSapDefeito ?? 'Defeito desconhecido'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Equipamento: ${anomalia.nomeEquipamento ?? 'Desconhecido'}'),
                  Text('Fase: ${anomalia.fase.name.toUpperCase()}'),
                  Text('Lado: ${anomalia.lado.name.toUpperCase()}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.visibility),
                    tooltip: 'Ver detalhes',
                    onPressed: () {
                      AppLogger.d(
                          '[ResumoAnomaliasPage] Visualizando anomalia ID ${anomalia.id}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Scaffold(
                            appBar: AppBar(
                                title: const Text('Detalhes da Anomalia')),
                            body: AnomaliaDetalhesWidget(anomalia: anomalia),
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Editar anomalia',
                    onPressed: () {
                      AppLogger.d(
                          '[ResumoAnomaliasPage] Editando anomalia ID ${anomalia.id}');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AnomaliaFormWidget(
                                  perguntaId: anomalia.perguntaId!,
                                  anomaliaExistente: anomalia,
                                )),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    tooltip: 'Remover anomalia',
                    onPressed: () async {
                      AppLogger.d(
                          '[ResumoAnomaliasPage] Removendo anomalia ID ${anomalia.id}');
                      await controller.removerAnomalia(anomalia.id!);
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
          AppLogger.d(
              '[ResumoAnomaliasPage] Botão de adicionar anomalia pressionado');
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const AnomaliaFormWidget(
                      perguntaId: '',
                    )),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
