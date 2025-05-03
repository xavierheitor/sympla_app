import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/constants/tipo_atividade_mobile.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/core/storage/daos/atividade/atividade_dao.dart';
import 'package:sympla_app/core/data/models/atividade_model.dart';
import 'package:sympla_app/core/domain/repositories/atividade/atividade_repository.dart';
import 'package:sympla_app/core/storage/daos/atividade/tipo_atividade_dao.dart';

class AtividadeRepositoryImpl implements AtividadeRepository {
  final DioClient dio;
  final AtividadeDao dao;
  final TipoAtividadeDao tipoAtividadeDao;
  final AppDatabase db;

  AtividadeRepositoryImpl({
    required this.dio,
    required this.db,
  })  : dao = db.atividadeDao,
        tipoAtividadeDao = db.tipoAtividadeDao;

  @override
  Future<List<AtividadeTableCompanion>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.atividades);
      final dados = response.data as List;

      AppLogger.d('🔍 Recebidos ${dados.length} atividades da API',
          tag: 'AtividadeRepo');

      return dados.map<AtividadeTableCompanion>((json) {
        return AtividadeTableCompanion(
          id: Value(json['id']),
          uuid: Value(json['uuid']),
          titulo: Value(json['titulo']),
          descricao: Value(json['descricao']),
          tipoAtividadeId: Value(json['tipoAtividadeId']),
          tipoAtividadeMobile: Value(
            TipoAtividadeMobile.values.firstWhere(
              (e) => e.name == json['tipoAtividadeMobile'],
              orElse: () => TipoAtividadeMobile.ivItIu,
            ),
          ),
          ordemServico: Value(json['ordemServico']),
          dataLimite: Value(DateTime.parse(json['dataLimite'])),
          createdAt: Value(DateTime.parse(json['createdAt'])),
          updatedAt: Value(DateTime.parse(json['updatedAt'])),
          sincronizado: const Value(true),
          subestacao: Value(json['subestacao']),
          equipamentoId: Value(json['equipamentoId']),
          status: Value(
            StatusAtividade.values.firstWhere(
              (e) => e.name == json['status'],
              orElse: () => StatusAtividade.pendente,
            ),
          ),
        );
      }).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AtividadeRepositoryImpl - buscarDaApi] ${erro.mensagem}',
          tag: 'AtividadeRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<bool> estaVazio() async {
    return await dao.estaVazio();
  }

  @override
  Future<void> salvarNoBanco(List<AtividadeTableCompanion> dados) async {
    try {
      await dao.sincronizarComApi(dados);
      AppLogger.d('💾 Atividades salvas no banco local', tag: 'AtividadeRepo');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AtividadeRepositoryImpl - salvarNoBanco] ${erro.mensagem}',
          tag: 'AtividadeRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<AtividadeTableData>> buscarTodas() async {
    try {
      final lista = await dao.buscarTodas();
      return lista;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AtividadeRepositoryImpl - buscarTodas] ${erro.mensagem}',
          tag: 'AtividadeRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<AtividadeModel>> buscarComEquipamento() async {
    try {
      return await dao.buscarComEquipamento();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AtividadeRepositoryImpl - buscarComEquipamento] ${erro.mensagem}',
          tag: 'AtividadeRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<AtividadeModel?> buscarEmAndamento() {
    try {
      return dao.buscarEmAndamento();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AtividadeRepositoryImpl - buscarEmAndamento] ${erro.mensagem}',
          tag: 'AtividadeRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> iniciarAtividade(AtividadeModel atividade) async {
    try {
      await dao.iniciarAtividade(atividade);
      AppLogger.d(
          '🔄 Atividade iniciada: ${atividade.titulo} (ID: ${atividade.id})',
          tag: 'AtividadeRepositoryImpl');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AtividadeRepositoryImpl - iniciarAtividade] ${erro.mensagem}',
          tag: 'AtividadeRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> finalizarAtividade(AtividadeModel atividade) async {
    try {
      await dao.finalizarAtividade(atividade);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AtividadeRepositoryImpl - finalizarAtividade] ${erro.mensagem}',
          tag: 'AtividadeRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<AtividadeModel?> buscarPorId(int id) {
    try {
      return dao.buscarPorId(id);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AtividadeRepositoryImpl - buscarPorId] ${erro.mensagem}',
          tag: 'AtividadeRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<TipoAtividadeTableData> getTipoAtividadeId(
      AtividadeModel atividade) async {
    try {
      final tipoAtividade =
          await tipoAtividadeDao.buscarPorId(atividade.tipoAtividadeId);
      return tipoAtividade;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AtividadeRepositoryImpl - getTipoAtividadeId] ${erro.mensagem}',
          tag: 'AtividadeRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }
}
