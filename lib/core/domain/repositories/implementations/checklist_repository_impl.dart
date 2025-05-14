import 'package:sympla_app/core/domain/dto/checklist/checklist_pergunta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_preenchido_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_resposta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/checklist_repository.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/checklist_dao.dart';

class ChecklistRepositoryImpl implements ChecklistRepository {
  final AppDatabase db;
  final ChecklistDao checklistDao;
  final DioClient dio;

  ChecklistRepositoryImpl(this.db, this.dio) : checklistDao = db.checklistDao;

  @override
  Future<void> atualizarDataPreenchimento(
      int checklistPreenchidoId, DateTime data) {
    // TODO: implement atualizarDataPreenchimento
    throw UnimplementedError();
  }

  @override
  Future<ChecklistPreenchidoTableDto?> buscarChecklistPreenchido(
      String atividadeId) {
    // TODO: implement buscarChecklistPreenchido
    throw UnimplementedError();
  }

  @override
  Future<ChecklistTableDto> buscarModeloPorTipoAtividade(
      String idTipoAtividade) {
    // TODO: implement buscarModeloPorTipoAtividade
    throw UnimplementedError();
  }

  @override
  Future<List<ChecklistPerguntaTableDto>> buscarPerguntasRelacionadas(
      String checklistId) {
    // TODO: implement buscarPerguntasRelacionadas
    throw UnimplementedError();
  }

  @override
  Future<List<ChecklistRespostaTableDto>> buscarRespostas(
      int checklistPreenchidoId) {
    // TODO: implement buscarRespostas
    throw UnimplementedError();
  }

  @override
  Future<bool> checklistEstaVazio() {
    // TODO: implement checklistEstaVazio
    throw UnimplementedError();
  }

  @override
  Future<int> criarChecklistPreenchido(ChecklistPreenchidoTableDto checklist) {
    // TODO: implement criarChecklistPreenchido
    throw UnimplementedError();
  }

  @override
  Future<void> deletarChecklistPreenchido(int checklistPreenchidoId) {
    // TODO: implement deletarChecklistPreenchido
    throw UnimplementedError();
  }

  @override
  Future<void> deletarRespostas(int checklistPreenchidoId) {
    // TODO: implement deletarRespostas
    throw UnimplementedError();
  }

  @override
  Future<bool> existeChecklistPreenchido(String atividadeId) {
    // TODO: implement existeChecklistPreenchido
    throw UnimplementedError();
  }

  @override
  Future<bool> existeRespostas(int checklistPreenchidoId) {
    // TODO: implement existeRespostas
    throw UnimplementedError();
  }

  @override
  Future<bool> salvarRespostas(List<ChecklistRespostaTableDto> respostas) {
    // TODO: implement salvarRespostas
    throw UnimplementedError();
  }
}
