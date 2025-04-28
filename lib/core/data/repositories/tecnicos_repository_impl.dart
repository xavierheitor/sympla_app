import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/tecnicos_dao.dart';
import 'package:sympla_app/core/domain/repositories/tecnicos_repository.dart';

class TecnicosRepositoryImpl implements TecnicosRepository {
  final TecnicosDao dao;
  final DioClient dio;
  final AppDatabase db;

  TecnicosRepositoryImpl({required this.dio, required this.db})
      : dao = db.tecnicosDao;

  @override
  Future<List<TecnicosTableData>> buscarTodos() async {
    final result = await dao.buscarTodos();
    return result;
  }

  @override
  Future<void> sincronizarTecnicos(
      List<TecnicosTableCompanion> tecnicos) async {
    try {
      final response = await dio.get(ApiConstants.tecnicos);
      final dados = response.data as List;

      final tecnicos = dados
          .map((json) => TecnicosTableCompanion(
                id: Value(json['id']),
                uuid: Value(json['uuid']),
                createdAt: Value(DateTime.now()),
                updatedAt: Value(DateTime.now()),
                sincronizado: const Value(true),
                nome: Value(json['nome']),
                matricula: Value(json['matricula']),
              ))
          .toList();
      await dao.sincronizarComApi(tecnicos);
    } catch (e) {
      throw ErrorHandler.tratar(e);
    }
  }
}
