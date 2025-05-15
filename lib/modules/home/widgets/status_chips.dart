import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';

class StatusChips extends StatelessWidget {
  const StatusChips({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AtividadeController>();

    return Obx(() {
      final atividades = controller.atividades;

      int contar(StatusAtividade status) =>
          atividades.where((a) => a.status == status).length;

      return SizedBox(
        height: 64,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            _statusBox('Pend', contar(StatusAtividade.pendente), Colors.blue),
            const SizedBox(width: 8),
            _statusBox(
                'Andam', contar(StatusAtividade.emAndamento), Colors.orange),
            const SizedBox(width: 8),
            _statusBox(
                'Concl', contar(StatusAtividade.concluido), Colors.green),
            const SizedBox(width: 8),
            _statusBox(
                'Canc', contar(StatusAtividade.cancelado), Colors.redAccent),
          ],
        ),
      );
    });
  }

  Widget _statusBox(String label, int count, Color color) {
    final isZero = count == 0;
    final bgColor =
        isZero ? Colors.grey.withOpacity(0.1) : color.withOpacity(0.1);
    final borderColor =
        isZero ? Colors.grey.withOpacity(0.4) : color.withOpacity(0.4);
    final textColor = isZero ? Colors.grey : color;

    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$count',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          ),
          Text(
            label,
            style: TextStyle(
                fontSize: 12, color: textColor, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
