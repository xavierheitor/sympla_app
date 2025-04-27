import 'package:sympla_app/core/storage/app_database.dart';

abstract class TecnicosRepository {
  Future<void> sincronizarTecnicos(List<TecnicosTableCompanion> tecnicos);
  Future<List<TecnicosTableData>> buscarTodos();
}
