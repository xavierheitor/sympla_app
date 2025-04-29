import 'dart:typed_data';

class AssinaturaModel {
  final Uint8List assinatura;
  final int tecnicoId;

  AssinaturaModel({
    required this.assinatura,
    required this.tecnicoId,
  });
}
