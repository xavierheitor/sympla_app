import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusChips extends StatelessWidget {
  final RxInt pendentes;
  final RxInt emAndamento;
  final RxInt concluidas;
  final RxInt canceladas;

  const StatusChips({
    super.key,
    required this.pendentes,
    required this.emAndamento,
    required this.concluidas,
    required this.canceladas,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        height: 64,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            _statusBox('Pend', pendentes.value, Colors.blue),
            const SizedBox(width: 8),
            _statusBox('Andam', emAndamento.value, Colors.orange),
            const SizedBox(width: 8),
            _statusBox('Concl', concluidas.value, Colors.green),
            const SizedBox(width: 8),
            _statusBox('Canc', canceladas.value, Colors.redAccent),
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
