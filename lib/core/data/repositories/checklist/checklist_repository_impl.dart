// ======== Implementação: ChecklistRepositoryImpl ========

import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/checklist/checklist_dao.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_repository.dart';

class ChecklistRepositoryImpl implements ChecklistRepository {
  final ChecklistDao dao;
  final DioClient dio;
  final AppDatabase db;

  ChecklistRepositoryImpl({required this.dio, required this.db})
      : dao = db.checklistDao;

  @override
  Future<List<ChecklistTableData>> buscarTodos() async {
    try {
      return await dao.getAll();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistRepositoryImpl - buscarTodos] ${erro.mensagem}',
          tag: 'ChecklistRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<ChecklistTableCompanion>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.checklist);
      final dados = response.data as List;

      return dados.map((json) {
        return ChecklistTableCompanion.insert(
          uuid: json['uuid'] as String,
          nome: json['nome'] as String,
          createdAt: DateTime.parse(json['created_at']),
          updatedAt: DateTime.parse(json['updated_at']),
          sincronizado: const Value(true),
        );
      }).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistRepositoryImpl - buscarDaApi] ${erro.mensagem}',
          tag: 'ChecklistRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> salvarNoBanco(List<ChecklistTableCompanion> dados) async {
    try {
      await dao.sincronizarComApi(dados);
      AppLogger.d('💾 Checklist sincronizado com sucesso');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistRepositoryImpl - salvarNoBanco] ${erro.mensagem}',
          tag: 'ChecklistRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }
}
