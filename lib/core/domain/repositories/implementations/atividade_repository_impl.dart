import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';
import 'package:sympla_app/core/domain/dto/atividade/tipo_atividade_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/atividade_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/atividade_dao.dart';

class AtividadeRepositoryImpl implements AtividadeRepository {
  final AppDatabase db;
  final AtividadeDao atividadeDao;
  final DioClient dio;

  AtividadeRepositoryImpl(this.db, this.dio) : atividadeDao = db.atividadeDao;

  @override
  Future<AtividadeTableDto?> buscarAtividade(String atividadeId) async {
    try {
      final atividade = await atividadeDao.buscarAtividadePorId(atividadeId);
      return atividade != null ? AtividadeTableDto.fromData(atividade) : null;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[atividade_repository_impl - buscarAtividade] ${erro.mensagem}',
        tag: 'AtividadeRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }

  @override
  Future<AtividadeTableDto?> buscarAtividadeEmAndamento() async {
    try {
      final atividade = await atividadeDao.buscarEmAndamento();
      return atividade != null ? AtividadeTableDto.fromData(atividade) : null;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[atividade_repository_impl - buscarAtividadeEmAndamento] ${erro.mensagem}',
        tag: 'AtividadeRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }

  @override
  Future<TipoAtividadeTableDto?> buscarTipoAtividadePorAtividadeId(
      String atividadeId) async {
    try {
      final tipoAtividade =
          await atividadeDao.buscarTipoAtividadePorId(atividadeId);
      return TipoAtividadeTableDto.fromData(tipoAtividade);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[atividade_repository_impl - buscarTipoAtividadePorAtividadeId] ${erro.mensagem}',
        tag: 'AtividadeRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }

  @override
  Future<List<AtividadeTableDto>> buscarTodasAtividades() async {
    try {
      final atividades = await atividadeDao.buscarTodasAtividades();
      return atividades.map((e) => AtividadeTableDto.fromData(e)).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[atividade_repository_impl - buscarTodasAtividades] ${erro.mensagem}',
        tag: 'AtividadeRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      return [];
    }
  }

  @override
  Future<List<TipoAtividadeTableDto>> buscarTodosTiposAtividade() async {
    try {
      final tiposAtividade = await atividadeDao.buscarTodosTiposAtividade();
      return tiposAtividade
          .map((e) => TipoAtividadeTableDto.fromData(e))
          .toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[atividade_repository_impl - buscarTodosTiposAtividade] ${erro.mensagem}',
        tag: 'AtividadeRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      return [];
    }
  }

  @override
  Future<void> finalizarAtividade(AtividadeTableDto atividade) async {
    try {
      await atividadeDao.finalizarAtividade(atividade.toCompanion());
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[atividade_repository_impl - finalizarAtividade] ${erro.mensagem}',
        tag: 'AtividadeRepositoryImpl',
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  Future<void> iniciarAtividade(AtividadeTableDto atividade) async {
    try {
      await atividadeDao.iniciarAtividade(atividade.toCompanion());
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[atividade_repository_impl - iniciarAtividade] ${erro.mensagem}',
        tag: 'AtividadeRepositoryImpl',
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  Future<List<AtividadeTableDto>> buscarAtividadesComEquipamento() async {
    try {
      final rows = await atividadeDao.buscarComEquipamento();

      return rows.map((row) {
        final atividade = row.readTable(db.atividadeTable);
        final equipamento = row.readTable(db.equipamentoTable);
        final tipoAtividade = row.readTable(db.tipoAtividadeTable);

        return AtividadeTableDto.fromJoin(
            atividade, equipamento, tipoAtividade);
      }).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[atividade_repository_impl - buscarAtividadesComEquipamento] ${erro.mensagem}',
        tag: 'AtividadeRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      return [];
    }
  }
}
