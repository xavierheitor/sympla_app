import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/core/storage/converters/tipo_atividade_mobile_converter.dart';
import 'package:sympla_app/core/storage/daos/atividade_dao.dart';
import 'package:sympla_app/data/models/atividade_com_equipamento.dart';
import 'package:sympla_app/domain/repositories/atividade_repository.dart';

class AtividadeRepositoryImpl implements AtividadeRepository {
  final DioClient dio;
  final AtividadeDao dao;
  final AppDatabase db;

  AtividadeRepositoryImpl({
    required this.dio,
    required this.db,
  }) : dao = db.atividadeDao;

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
  Future<List<AtividadeComEquipamento>> buscarComEquipamento() async {
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
}
