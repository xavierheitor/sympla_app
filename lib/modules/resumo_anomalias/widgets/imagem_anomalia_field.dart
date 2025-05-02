import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

class ImagemAnomaliaField extends StatelessWidget {
  final ValueNotifier<Uint8List?> imagemBytesNotifier;

  const ImagemAnomaliaField({
    super.key,
    required this.imagemBytesNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<Uint8List?>(
          valueListenable: imagemBytesNotifier,
          builder: (context, imagemBytes, _) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: imagemBytes == null
                  ? const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '📸 Necessário tirar uma foto',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        SizedBox(height: 8),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('📷 Foto da Anomalia',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () =>
                              _abrirImagemEmTelaCheia(context, imagemBytes),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.memory(
                              imagemBytes,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                AppLogger.d(
                                    '[ImagemAnomaliaField] Imagem removida');
                                imagemBytesNotifier.value = null;
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                              label: const Text('Remover imagem',
                                  style: TextStyle(color: Colors.red)),
                            ),
                            const Spacer(),
                            TextButton.icon(
                              onPressed: () =>
                                  _abrirImagemEmTelaCheia(context, imagemBytes),
                              icon: const Icon(Icons.fullscreen),
                              label: const Text('Ver em tela cheia'),
                            ),
                          ],
                        ),
                      ],
                    ),
            );
          },
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () => _selecionarImagem(
                context,
                imagemBytesNotifier,
                ImageSource.camera,
              ),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Câmera'),
            ),
            ElevatedButton.icon(
              onPressed: () => _selecionarImagem(
                context,
                imagemBytesNotifier,
                ImageSource.gallery,
              ),
              icon: const Icon(Icons.photo_library),
              label: const Text('Galeria'),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _abrirImagemEmTelaCheia(BuildContext context, Uint8List imagem) {
    Get.dialog(
      Stack(
        children: [
          Container(
            color: Colors.black,
            child: Center(
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 0.5,
                maxScale: 4,
                child: Image.memory(
                  imagem,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            top: 32,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
      barrierColor: Colors.black.withOpacity(0.95),
    );
  }

  Future<void> _selecionarImagem(
    BuildContext context,
    ValueNotifier<Uint8List?> notifier,
    ImageSource origem,
  ) async {
    try {
      final picker = ImagePicker();
      final XFile? imagem = await picker.pickImage(source: origem);
      if (imagem != null) {
        final bytes = await imagem.readAsBytes();
        AppLogger.d('[ImagemAnomaliaField] Imagem selecionada: ${imagem.path}');
        notifier.value = bytes;
      }
    } catch (e) {
      AppLogger.e('[ImagemAnomaliaField] Erro ao selecionar imagem: $e');
    }
  }
}
