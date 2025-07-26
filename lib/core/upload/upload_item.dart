import 'package:sympla_app/core/domain/dto/sync/atividade_sync_dto.dart';

class UploadItem {
  final AtividadeSyncDto atividadeSync;
  int tentativas;
  String? erro;
  DateTime? dataCriacao;

  UploadItem(this.atividadeSync, {this.tentativas = 0, this.erro}) : dataCriacao = DateTime.now();

  // Opcional: métodos utilitários
  void marcarErro(String erro) {
    this.erro = erro;
    tentativas++;
  }

  void limparErro() {
    erro = null;
  }

  bool get possuiErro => erro != null;

  bool get podeTentarNovamente => tentativas < 3;

  Duration get tempoNaFila => DateTime.now().difference(dataCriacao!);
}
