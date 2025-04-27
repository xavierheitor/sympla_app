import 'package:sympla_app/core/storage/app_database.dart';

abstract class AprPerguntasRepository {
  Future<List<AprQuestionTableCompanion>> buscarDaApi();
  Future<void> sincronizar();
  Future<bool> estaVazio();
  Future<List<AprQuestionTableData>> buscarTodos(int idApr);
}
