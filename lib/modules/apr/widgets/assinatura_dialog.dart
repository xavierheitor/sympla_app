import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

class AssinaturaDialog extends StatefulWidget {
  final void Function(Uint8List assinaturaBytes) onSalvar;

  const AssinaturaDialog({
    super.key,
    required this.onSalvar,
  });

  @override
  State<AssinaturaDialog> createState() => _AssinaturaDialogState();
}

class _AssinaturaDialogState extends State<AssinaturaDialog> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _salvarAssinatura() async {
    if (_controller.isNotEmpty) {
      final bytes = await _controller.toPngBytes();
      if (bytes != null) {
        widget.onSalvar(bytes);
        Get.back();
      }
    } else {
      Get.snackbar(
        'Erro',
        'Por favor, assine antes de salvar',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Assinatura'),
      content: SizedBox(
        height: 300,
        child: Column(
          children: [
            Expanded(
              child: Signature(
                controller: _controller,
                backgroundColor: Colors.grey[200]!,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _controller.clear,
                    child: const Text('Limpar'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _salvarAssinatura,
                    child: const Text('Salvar'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
