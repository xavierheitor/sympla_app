import 'package:sympla_app/core/storage/app_database.dart';

abstract class AprRespostasRepository {
  Future<bool> salvarRespostas(List<AprRespostaTableCompanion> respostas);
  Future<bool> existeRespostas(int aprPreenchidaId);
  Future<List<AprRespostaTableData>> buscarRespostas(int aprPreenchidaId);

  Future<void> deletarRespostasDaApr(int aprPreenchidaId);
}
