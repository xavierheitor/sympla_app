import 'package:sympla_app/core/storage/app_database.dart';

abstract class AprRespostasRepository {
  Future<bool> salvarRespostas(
      int aprPreenchidaId, List<AprRespostaTableCompanion> respostas);
  Future<List<AprRespostaTableData>> buscarRespostas(int aprPreenchidaId);
}
