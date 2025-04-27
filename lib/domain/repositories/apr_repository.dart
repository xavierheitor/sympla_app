import 'package:sympla_app/core/storage/app_database.dart';

abstract class AprRepository {
  Future<List<AprTableCompanion>> buscarDaApi();
  Future<void> salvarNoBanco(AprTableCompanion apr);
  Future<void> sincronizar();
  Future<bool> estaVazio();
  Future<AprTableData> buscarPorTipoAtividade(int idTipoAtividade);
}
