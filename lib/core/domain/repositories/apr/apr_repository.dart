import 'package:sympla_app/core/storage/app_database.dart';

abstract class AprRepository {
  Future<List<AprTableCompanion>> buscarDaApi();
  Future<void> salvarNoBanco(AprTableCompanion apr);
  Future<void> sincronizar(List<AprTableCompanion> lista);
  Future<bool> estaVazio();
  Future<AprTableData> buscarPorTipoAtividade(int idTipoAtividade);

  Future<int> criarAprPreenchida(AprPreenchidaTableCompanion apr);
  Future<void> atualizarDataPreenchimento(
      int aprPreenchidaId, DateTime dataPreenchimento);
  Future<void> deletarAprPreenchida(int aprPreenchidaId);
}
