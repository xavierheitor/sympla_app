import 'package:sympla_app/core/storage/converters/resposta_apr_converter.dart';

class RespostaFormulario {
  final int perguntaId;
  RespostaApr? resposta; // <-- aqui pode ser nulo até o usuário escolher
  String observacao;

  RespostaFormulario({
    required this.perguntaId,
    this.resposta,
    this.observacao = '',
  });
}
