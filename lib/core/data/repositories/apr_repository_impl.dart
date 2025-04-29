// === AprRepositoryImpl (corrigido) ===

import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/apr_dao.dart';
import 'package:sympla_app/core/domain/repositories/apr_repository.dart';

class AprRepositoryImpl implements AprRepository {
  final DioClient dio;
  final AppDatabase db;
  final AprDao dao;

  AprRepositoryImpl({required this.dio, required this.db}) : dao = db.aprDao;

  @override
  Future<List<AprTableCompanion>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.aprs);
      final dados = response.data as List;

      return dados.map<AprTableCompanion>((json) {
        return AprTableCompanion(
          id: Value(json['id']),
          uuid: Value(json['uuid']),
          nome: Value(json['nome']),
          descricao: Value(json['descricao']),
          createdAt: Value(DateTime.parse(json['createdAt'])),
          updatedAt: Value(DateTime.parse(json['updatedAt'])),
          sincronizado: const Value(true),
        );
      }).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprRepositoryImpl - buscarDaApi] ${erro.mensagem}',
          tag: 'AprRepositoryImpl', error: e, stackTrace: s);
      return [];
    }
  }

  @override
  Future<void> sincronizar(List<AprTableCompanion> entradas) async {
    await dao.sincronizarComApi(entradas);
  }

  @override
  Future<AprTableData> buscarPorTipoAtividade(int idTipoAtividade) =>
      dao.buscarPorTipoAtividade(idTipoAtividade);

  @override
  Future<void> salvarNoBanco(AprTableCompanion apr) =>
      dao.inserirOuAtualizar(apr);

  @override
  Future<bool> estaVazio() => dao.estaVazio();
}
