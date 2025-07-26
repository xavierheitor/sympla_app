import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';

class UploadItem {
  final AtividadeTableDto atividade;
  int tentativas;
  String? erro;

  UploadItem(this.atividade, {this.tentativas = 0, this.erro});

  // Opcional: métodos utilitários
  void marcarErro(String erro) {
    this.erro = erro;
    tentativas++;
  }

  bool get possuiErro => erro != null;
}