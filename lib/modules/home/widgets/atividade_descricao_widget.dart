import 'package:flutter/material.dart';

/// Widget que exibe um item de descrição da atividade com ícone e texto
class AtividadeDescricaoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;
  final double iconSize;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const AtividadeDescricaoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
    this.iconSize = 16,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: iconSize,
            color: iconColor ?? Theme.of(context).iconTheme.color,
          ),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: labelStyle ?? const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: valueStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
