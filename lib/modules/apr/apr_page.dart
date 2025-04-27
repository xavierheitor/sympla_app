import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/modules/apr/apr_controller.dart';
import 'package:sympla_app/modules/apr/widgets/apr_assinatura_card.dart';
import 'package:sympla_app/modules/apr/widgets/apr_pergunta_card.dart';
import 'package:sympla_app/modules/apr/widgets/assinatura_dialog.dart';

class AprPage extends StatelessWidget {
  final AprController controller = Get.find<AprController>();

  AprPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Análise Preliminar de Risco'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: controller.salvarRespostas,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Perguntas
            ...controller.perguntas.map((pergunta) {
              final respostaSelecionada = controller.respostas.firstWhereOrNull(
                (r) => r.perguntaId.value == pergunta.id,
              );

              return AprPerguntaCard(
                pergunta: pergunta.texto,
                respostaSelecionada: respostaSelecionada?.resposta.value,
                onRespostaSelecionada: (resposta) {
                  controller.atualizarResposta(pergunta.id, resposta);
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

            ...controller.assinaturas.map(
              (assinatura) => AprAssinaturaCard(
                assinaturaBytes:
                    Uint8List.fromList(assinatura.assinatura.codeUnits),
              ),
            ),

            const SizedBox(height: 24),

            // Botão Adicionar Assinatura
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.dialog(
                    AssinaturaDialog(onSalvar: controller.adicionarAssinatura),
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
