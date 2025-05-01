import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/checklist/checklist_grupo_dao.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_grupo_repository.dart';

class ChecklistGrupoRepositoryImpl implements ChecklistGrupoRepository {
  final ChecklistGrupoDao dao;
  final DioClient dio;
  final AppDatabase db;

  ChecklistGrupoRepositoryImpl({required this.dio, required this.db})
      : dao = db.checklistGrupoDao;

  @override
  Future<List<ChecklistGrupoTableData>> buscarTodos() async {
    try {
      return await dao.getAll();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistGrupoRepositoryImpl - buscarTodos] ${erro.mensagem}',
          tag: 'ChecklistGrupoRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<ChecklistGrupoTableCompanion>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.checklistGrupos);
      final dados = response.data as List;

      return dados.map((json) {
        return ChecklistGrupoTableCompanion.insert(
          uuid: json['uuid'] as String,
          nome: json['nome'] as String,
          createdAt: DateTime.parse(json['created_at']),
          updatedAt: DateTime.parse(json['updated_at']),
          sincronizado: const Value(true),
        );
      }).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistGrupoRepositoryImpl - buscarDaApi] ${erro.mensagem}',
          tag: 'ChecklistGrupoRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> salvarNoBanco(List<ChecklistGrupoTableCompanion> dados) async {
    try {
      await dao.sincronizarComApi(dados);
      AppLogger.d('💾 ChecklistGrupo sincronizado com sucesso');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistGrupoRepositoryImpl - salvarNoBanco] ${erro.mensagem}',
          tag: 'ChecklistGrupoRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }
}
