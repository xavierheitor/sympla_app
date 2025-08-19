import 'package:sympla_app/core/domain/dto/sync/atividade_sync_dto.dart';

/// 📦 Item de upload
///
/// Responsabilidades:
/// - Representa uma atividade a ser enviada
/// - Gerencia tentativas de upload
/// - Armazena informações de erro
/// - Calcula tempo na fila
class UploadItem {
  final AtividadeSyncDto atividadeSync;
  int tentativas;
  String? erro;
  DateTime? dataCriacao;

  /// Próxima data/hora em que o item pode ser reprocessado (backoff)
  DateTime? proximaTentativa;

  /// Máximo de tentativas antes de desistir do reenvio
  static const int maxTentativas = 3;

  UploadItem(
    this.atividadeSync, {
    this.tentativas = 0,
    this.erro,
  })  : dataCriacao = DateTime.now(),
        proximaTentativa = DateTime.now();

  // Opcional: métodos utilitários
  void marcarErro(String erro) {
    this.erro = erro;
    tentativas++;
  }

  void limparErro() {
    erro = null;
  }

  bool get possuiErro => erro != null;

  bool get podeTentarNovamente => tentativas < maxTentativas;

  Duration get tempoNaFila => DateTime.now().difference(dataCriacao!);
}
