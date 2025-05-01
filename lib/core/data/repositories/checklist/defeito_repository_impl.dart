import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/checklist/defeito_dao.dart';
import 'package:sympla_app/core/domain/repositories/checklist/defeito_repository.dart';

class DefeitoRepositoryImpl implements DefeitoRepository {
  final DioClient dio;
  final AppDatabase db;
  final DefeitoDao dao;

  DefeitoRepositoryImpl({required this.dio, required this.db})
      : dao = db.defeitoDao;

  @override
  Future<List<DefeitoTableData>> buscarTodos() async {
    try {
      return await dao.getAll();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[DefeitoRepositoryImpl - buscarTodos] ${erro.mensagem}',
          tag: 'DefeitoRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<DefeitoTableData>> getByGrupoId(int grupoId) async {
    try {
      return await dao.getByGrupoId(grupoId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[DefeitoRepositoryImpl - getByGrupoId] ${erro.mensagem}',
          tag: 'DefeitoRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<DefeitoTableData>> getBySubgrupoId(int subgrupoId) async {
    try {
      return await dao.getBySubgrupoId(subgrupoId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[DefeitoRepositoryImpl - getBySubgrupoId] ${erro.mensagem}',
          tag: 'DefeitoRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<DefeitoTableCompanion>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.defeitos);
      final dados = response.data as List;

      return dados.map((json) {
        return DefeitoTableCompanion.insert(
          uuid: json['uuid'] as String,
          grupoId: json['grupo_id'] as int,
          subgrupoId: json['subgrupo_id'] as int,
          codigoSap: json['codigo_sap'] as String,
          descricao: json['descricao'] as String,
          prioridade: json['prioridade'] as String,
          createdAt: DateTime.parse(json['created_at']),
          updatedAt: DateTime.parse(json['updated_at']),
          sincronizado: const Value(true),
        );
      }).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[DefeitoRepositoryImpl - buscarDaApi] ${erro.mensagem}',
          tag: 'DefeitoRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> salvarNoBanco(List<DefeitoTableCompanion> dados) async {
    try {
      await dao.sincronizarComApi(dados);
      AppLogger.d('💾 Defeitos sincronizados com sucesso',
          tag: 'DefeitoRepositoryImpl');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[DefeitoRepositoryImpl - salvarNoBanco] ${erro.mensagem}',
          tag: 'DefeitoRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }
}
