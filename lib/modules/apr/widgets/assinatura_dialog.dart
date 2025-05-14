import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:sympla_app/core/domain/dto/tecnico_table_dto.dart';

class AssinaturaDialog extends StatefulWidget {
  final void Function(Uint8List assinaturaBytes, String tecnicoId) onSalvar;
  final List<TecnicoTableDto> tecnicos;

  const AssinaturaDialog({
    super.key,
    required this.onSalvar,
    required this.tecnicos,
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

  final TextEditingController _tecnicoController = TextEditingController();
  TecnicoTableDto? _tecnicoSelecionado;

  @override
  void dispose() {
    _controller.dispose();
    _tecnicoController.dispose();
    super.dispose();
  }

  Future<void> _salvarAssinatura() async {
    if (_controller.isNotEmpty && _tecnicoSelecionado != null) {
      final bytes = await _controller.toPngBytes();
      if (bytes != null) {
        widget.onSalvar(bytes, _tecnicoSelecionado!.uuid);
        Get.back();
      }
    } else {
      Get.snackbar(
        'Erro',
        _tecnicoSelecionado == null
            ? 'Por favor, selecione o técnico antes de salvar'
            : 'Por favor, assine antes de salvar',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 550, // aumentei um pouquinho a altura para acomodar o nome
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Assinatura',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            TypeAheadField<TecnicoTableDto>(
              suggestionsCallback: (pattern) {
                return widget.tecnicos
                    .where((tecnico) => tecnico.nome
                        .toLowerCase()
                        .contains(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, tecnico) {
                return ListTile(
                  title: Text(tecnico.nome),
                  subtitle: Text('Matrícula: ${tecnico.matricula}'),
                );
              },
              onSelected: (tecnico) {
                setState(() {
                  _tecnicoSelecionado = tecnico;
                  _tecnicoController.text = tecnico.nome;
                });
              },
              builder: (context, controller, focusNode) {
                _tecnicoController.value = controller.value;
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    labelText: 'Selecione o Técnico',
                    border: OutlineInputBorder(),
                  ),
                );
              },
              hideOnEmpty: true,
              hideOnError: true,
            ),
            const SizedBox(height: 12),
            if (_tecnicoSelecionado != null) ...[
              Row(
                children: [
                  const Icon(Icons.person, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Técnico selecionado: ${_tecnicoSelecionado!.nome}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
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
            ),
          ],
        ),
      ),
    );
  }
}
