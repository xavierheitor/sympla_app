import 'package:sympla_app/core/storage/app_database.dart';

abstract class AprPerguntasRepository {
  Future<List<AprQuestionTableCompanion>> buscarDaApi();
  Future<List<AprPerguntaRelacionamentoTableCompanion>>
      buscarRelacionamentosDaApi();
  Future<void> sincronizar(List<AprQuestionTableCompanion> lista);
  Future<bool> estaVazio();
  Future<List<AprQuestionTableData>> buscarTodos(int idApr);
  Future<void> sincronizarRelacionamentos(
      List<AprPerguntaRelacionamentoTableCompanion> lista);
}
