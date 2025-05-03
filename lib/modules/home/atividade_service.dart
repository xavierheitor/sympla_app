import 'package:sympla_app/core/data/models/atividade_model.dart';
import 'package:sympla_app/core/domain/repositories/atividade/atividade_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class AtividadeService {
  final AtividadeRepository atividadeRepository;

  AtividadeService({required this.atividadeRepository});

  Future<List<AtividadeTableData>> buscarTodas() async {
    try {
      return await atividadeRepository.buscarTodas();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AtividadeSyncService - buscarTodas] ${erro.mensagem}',
          tag: 'AtividadeSync', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<AtividadeModel>> buscarComEquipamento() async {
    try {
      return await atividadeRepository.buscarComEquipamento();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AtividadeSyncService - buscarComEquipamento] ${erro.mensagem}',
          tag: 'AtividadeSync',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<AtividadeModel?> buscarAtividadeEmAndamento() async {
    try {
      return await atividadeRepository.buscarEmAndamento();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AtividadeSyncService - buscarAtividadeEmAndamento] ${erro.mensagem}',
          tag: 'AtividadeSync',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<void> iniciarAtividade(AtividadeModel atividade) async {
    try {
      await atividadeRepository.iniciarAtividade(atividade);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AtividadeSyncService - iniciarAtividade] ${erro.mensagem}',
          tag: 'AtividadeSync', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> finalizarAtividade(AtividadeModel atividade) async {
    try {
      await atividadeRepository.finalizarAtividade(atividade);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AtividadeSyncService - finalizarAtividade] ${erro.mensagem}',
          tag: 'AtividadeSync',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<TipoAtividadeTableData> getTipoAtividadeId(
      AtividadeModel atividade) async {
    try {
      return await atividadeRepository.getTipoAtividadeId(atividade);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AtividadeService - getTipoAtividadeId] ${erro.mensagem}',
          tag: 'AtividadeService', error: e, stackTrace: s);
      rethrow;
    }
  }
}
