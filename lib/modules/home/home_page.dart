import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/modules/home/home_controller.dart';
import 'package:sympla_app/modules/home/widgets/app_drawer.dart';
import 'package:sympla_app/modules/home/widgets/atividade_card_widget.dart';
import 'package:sympla_app/modules/home/widgets/status_chips.dart';

class HomePage extends StatelessWidget {
  final controller = Get.find<HomeController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sympla Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.sair,
          )
        ],
      ),
      drawer: AppDrawer(session: controller.session),
      body: Obx(() {
        final atividadeCtrl = controller.atividadeController;

        if (atividadeCtrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (atividadeCtrl.atividades.isEmpty) {
          return const Center(child: Text('Nenhuma atividade encontrada'));
        }

        final atividadeEmAndamento = atividadeCtrl.atividadeEmAndamento.value;
        final outrasAtividades = atividadeCtrl.atividades
            .where((a) => a.id != atividadeEmAndamento?.id)
            .toList();

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: StatusChips(
                pendentes: atividadeCtrl.atividadesPendentes,
                emAndamento: atividadeCtrl.atividadesEmAndamento,
                concluidas: atividadeCtrl.atividadesConcluidas,
                canceladas: atividadeCtrl.atividadesCanceladas,
              ),
            ),
            const SizedBox(height: 8),
            if (atividadeEmAndamento != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AtividadeCard(
                  atividade: atividadeEmAndamento,
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Nenhuma atividade em andamento',
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: outrasAtividades.length,
                itemBuilder: (context, index) {
                  final atividade = outrasAtividades[index];
                  return AtividadeCard(atividade: atividade);
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
