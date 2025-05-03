import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CampoData extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CampoData({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final dataSelecionada = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (dataSelecionada != null) {
          controller.text = DateFormat('dd/MM/yyyy').format(dataSelecionada);
        }
      },
      child: AbsorbPointer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(labelText: label),
          ),
        ),
      ),
    );
  }
}
