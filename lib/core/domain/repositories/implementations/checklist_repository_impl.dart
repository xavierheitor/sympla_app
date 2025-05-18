import 'package:sympla_app/core/domain/dto/checklist/checklist_pergunta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_preenchido_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_resposta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/checklist_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
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
      int checklistPreenchidoId, DateTime data) async {
    try {
      await checklistDao.atualizarDataPreenchimento(
          checklistPreenchidoId, data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[checklist_repository_impl - atualizarDataPreenchimento] ${erro.mensagem}',
        tag: 'ChecklistRepositoryImpl',
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  Future<ChecklistPreenchidoTableDto?> buscarChecklistPreenchido(
      String atividadeId) async {
    try {
      final checklistPreenchido =
          await checklistDao.buscarPorAtividade(atividadeId);
      return checklistPreenchido != null
          ? ChecklistPreenchidoTableDto.fromData(checklistPreenchido)
          : null;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[checklist_repository_impl - buscarChecklistPreenchido] ${erro.mensagem}',
        tag: 'ChecklistRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }

  @override
  Future<ChecklistTableDto?> buscarModeloPorTipoAtividade(
      String idTipoAtividade) async {
    try {
      final checklist =
          await checklistDao.buscarPorTipoAtividade(idTipoAtividade);
      return checklist != null ? ChecklistTableDto.fromData(checklist) : null;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[checklist_repository_impl - buscarModeloPorTipoAtividade] ${erro.mensagem}',
        tag: 'ChecklistRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }

  @override
  Future<List<ChecklistPerguntaTableDto>> buscarPerguntasRelacionadas(
      String checklistId) async {
    try {
      final perguntas =
          await checklistDao.buscarPerguntasPorChecklist(checklistId);
      return perguntas
          .map((e) => ChecklistPerguntaTableDto.fromData(e))
          .toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[checklist_repository_impl - buscarPerguntasRelacionadas] ${erro.mensagem}',
        tag: 'ChecklistRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      return [];
    }
  }

  @override
  Future<List<ChecklistRespostaTableDto>> buscarRespostas(
      int checklistPreenchidoId) async {
    try {
      final respostas = await checklistDao
          .buscarRespostasPorPreenchido(checklistPreenchidoId);
      return respostas
          .map((e) => ChecklistRespostaTableDto.fromData(e))
          .toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(erro.mensagem, error: e, stackTrace: s);
      return [];
    }
  }

  @override
  Future<bool> checklistEstaVazio() async {
    try {
      final checklist = await checklistDao.estaVazioChecklist();
      return checklist;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(erro.mensagem, error: e, stackTrace: s);
      return false;
    }
  }

  @override
  Future<int> criarChecklistPreenchido(
      ChecklistPreenchidoTableDto checklist) async {
    try {
      final id = await checklistDao.criarChecklistPreenchido(checklist);
      return id;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(erro.mensagem, error: e, stackTrace: s);
      return 0;
    }
  }

  @override
  Future<void> deletarChecklistPreenchido(int checklistPreenchidoId) async {
    try {
      await checklistDao.deletarChecklistPreenchido(checklistPreenchidoId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(erro.mensagem, error: e, stackTrace: s);
    }
  }

  @override
  Future<void> deletarRespostas(int checklistPreenchidoId) async {
    try {
      await checklistDao.deletarRespostasPorPreenchido(checklistPreenchidoId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(erro.mensagem, error: e, stackTrace: s);
    }
  }

  @override
  Future<bool> existeChecklistPreenchido(String atividadeId) async {
    try {
      final checklist = await checklistDao.buscarPorAtividade(atividadeId);
      return checklist != null;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(erro.mensagem, error: e, stackTrace: s);
      return false;
    }
  }

  @override
  Future<bool> existeRespostas(int checklistPreenchidoId) async {
    try {
      final respostas = await checklistDao
          .buscarRespostasPorPreenchido(checklistPreenchidoId);
      return respostas.isNotEmpty;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(erro.mensagem, error: e, stackTrace: s);
      return false;
    }
  }

  @override
  Future<bool> salvarRespostas(
      List<ChecklistRespostaTableDto> respostas) async {
    try {
      await checklistDao
          .salvarRespostas(respostas.map((e) => e.toCompanion()).toList());
      return true;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(erro.mensagem, error: e, stackTrace: s);
      return false;
    }
  }
}
