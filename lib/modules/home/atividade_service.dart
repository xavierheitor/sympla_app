import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';
import 'package:sympla_app/core/domain/dto/atividade/tipo_atividade_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/atividade_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

class AtividadeService {
  final AtividadeRepository atividadeRepository;

  AtividadeService({required this.atividadeRepository});

  Future<List<AtividadeTableDto>> buscarTodas() async {
    try {
      return await atividadeRepository.buscarTodasAtividades();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AtividadeSyncService - buscarTodas] ${erro.mensagem}',
          tag: 'AtividadeSync', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<AtividadeTableDto>> buscarComEquipamento() async {
    try {
      return await atividadeRepository.buscarAtividadesComEquipamento();
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

  Future<AtividadeTableDto?> buscarAtividadeEmAndamento() async {
    try {
      return await atividadeRepository.buscarAtividadeEmAndamento();
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

  Future<void> iniciarAtividade(AtividadeTableDto atividade) async {
    try {
      await atividadeRepository.iniciarAtividade(atividade);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AtividadeSyncService - iniciarAtividade] ${erro.mensagem}',
          tag: 'AtividadeSync', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> finalizarAtividade(AtividadeTableDto atividade) async {
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

  Future<TipoAtividadeTableDto> getTipoAtividadeId(
      AtividadeTableDto atividade) async {
    try {
      return await atividadeRepository
          .buscarTipoAtividadePorAtividadeId(atividade.uuid);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AtividadeService - getTipoAtividadeId] ${erro.mensagem}',
          tag: 'AtividadeService', error: e, stackTrace: s);
      rethrow;
    }
  }
}
