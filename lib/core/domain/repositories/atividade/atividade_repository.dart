import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/data/models/atividade_model.dart';

abstract class AtividadeRepository {
  Future<List<AtividadeTableCompanion>> buscarDaApi();
  Future<void> salvarNoBanco(List<AtividadeTableCompanion> dados);
  Future<bool> estaVazio();
  Future<List<AtividadeTableData>> buscarTodas();
  Future<List<AtividadeModel>> buscarComEquipamento();
  Future<AtividadeModel?> buscarEmAndamento();

  Future<void> iniciarAtividade(AtividadeModel atividade);

  Future<void> finalizarAtividade(AtividadeModel atividade);

  Future<AtividadeModel?> buscarPorId(int id);

  Future<TipoAtividadeTableData> getTipoAtividadeId(AtividadeModel atividade);
}
