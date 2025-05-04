import 'package:flutter/material.dart';

class CampoSelectEnum<T> extends StatelessWidget {
  final String label;
  final T? valorSelecionado;
  final List<T> valores;
  final String Function(T) labelBuilder;
  final void Function(T?) onChanged;

  const CampoSelectEnum({
    super.key,
    required this.label,
    required this.valorSelecionado,
    required this.valores,
    required this.labelBuilder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: valorSelecionado,
      items: valores
          .map((e) => DropdownMenuItem<T>(
                value: e,
                child: Text(labelBuilder(e)),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
