import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/checklist/checklist_subgrupo_dao.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_subgrupo_repository.dart';

class ChecklistSubgrupoRepositoryImpl implements ChecklistSubgrupoRepository {
  final ChecklistSubgrupoDao dao;
  final DioClient dio;
  final AppDatabase db;

  ChecklistSubgrupoRepositoryImpl({required this.dio, required this.db})
      : dao = db.checklistSubgrupoDao;

  @override
  Future<List<ChecklistSubgrupoTableData>> getAll() async {
    try {
      return await dao.getAll();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistSubgrupoRepositoryImpl - getAll] ${erro.mensagem}',
          tag: 'ChecklistSubgrupoRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<ChecklistSubgrupoTableData>> getByGrupoId(int grupoId) async {
    try {
      return await dao.getByGrupoId(grupoId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistSubgrupoRepositoryImpl - getByGrupoId] ${erro.mensagem}',
          tag: 'ChecklistSubgrupoRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<ChecklistSubgrupoTableCompanion>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.checklistSubgrupos);
      final dados = response.data as List;

      return dados.map((json) {
        return ChecklistSubgrupoTableCompanion.insert(
          uuid: json['uuid'] as String,
          grupoId: json['grupo_id'] as int,
          nome: json['nome'] as String,
          createdAt: DateTime.parse(json['created_at']),
          updatedAt: DateTime.parse(json['updated_at']),
          sincronizado: const Value(true),
        );
      }).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistSubgrupoRepositoryImpl - buscarDaApi] ${erro.mensagem}',
          tag: 'ChecklistSubgrupoRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> salvarNoBanco(
      List<ChecklistSubgrupoTableCompanion> dados) async {
    try {
      await dao.sincronizarComApi(dados);
      AppLogger.d('💾 ChecklistSubgrupo sincronizado com sucesso');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistSubgrupoRepositoryImpl - salvarNoBanco] ${erro.mensagem}',
          tag: 'ChecklistSubgrupoRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }
}
