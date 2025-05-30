import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/modules/apr/apr_controller.dart';
import 'package:sympla_app/modules/apr/widgets/apr_assinatura_card.dart';
import 'package:sympla_app/modules/apr/widgets/apr_pergunta_card.dart';
import 'package:sympla_app/modules/apr/widgets/assinatura_dialog.dart';

class AprPage extends StatelessWidget {
  final AprController controller = Get.find<AprController>();

  AprPage({super.key}) {
    AppLogger.d('📱 AprPage construída', tag: 'AprPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Análise Preliminar de Risco'),
        actions: [
          Obx(() {
            final podeSalvar = controller.podeSalvar();

            return IconButton(
              icon: const Icon(Icons.save),
              onPressed: podeSalvar
                  ? () {
                      AppLogger.d('💾 Botão salvar pressionado',
                          tag: 'AprPage');
                      controller.salvarRespostas();
                    }
                  : () {
                      AppLogger.d('❌ Tentativa de salvar APR incompleta',
                          tag: 'AprPage');
                      Get.snackbar(
                        'Formulário Incompleto',
                        'Responda todas as perguntas e colete pelo menos 2 assinaturas para salvar.',
                        backgroundColor: Get.theme.colorScheme.error,
                        colorText: Get.theme.colorScheme.onError,
                      );
                    },
              tooltip: podeSalvar
                  ? 'Salvar'
                  : 'Preencha todas as perguntas e colete 2 assinaturas',
            );
          }),
        ],
      ),
      body: Obx(() {
        //verifica se esta carregando
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        //retorna a lista de perguntas
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ...controller.perguntas.map((pergunta) {
              final respostaSelecionada =
                  controller.respostasFormulario.firstWhereOrNull(
                (r) => r.perguntaId == pergunta.uuid,
              );

              return AprPerguntaCard(
                pergunta: pergunta.texto,
                respostaSelecionada: respostaSelecionada?.resposta,
                onRespostaSelecionada: (resposta) {
                  AppLogger.d(
                      '✅ Resposta selecionada para pergunta ${pergunta.uuid}: $resposta',
                      tag: 'AprPage');
                  controller.atualizarResposta(pergunta.uuid, resposta);
                },
              );
            }),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Assinaturas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (controller.assinaturas.isEmpty)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Nenhuma assinatura adicionada ainda',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ...controller.assinaturas.map((assinatura) {
              final tecnico = controller.tecnicos.firstWhereOrNull(
                (t) => t.uuid == assinatura.tecnicoId,
              );
              final nomeTecnico = tecnico?.nome ?? 'Técnico desconhecido';

              return AprAssinaturaCard(
                nomeTecnico: nomeTecnico,
                assinaturaBytes: assinatura.assinatura,
              );
            }),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  AppLogger.d('✍️ Abrindo diálogo de assinatura',
                      tag: 'AprPage');
                  Get.dialog(
                    AssinaturaDialog(
                      onSalvar: (assinatura, tecnicoId) {
                        AppLogger.d('✅ Assinatura capturada, salvando...',
                            tag: 'AprPage');
                        controller.adicionarAssinatura(assinatura, tecnicoId);
                      },
                      tecnicos: controller.tecnicos,
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Adicionar Assinatura'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        );
      }),
    );
  }
}
