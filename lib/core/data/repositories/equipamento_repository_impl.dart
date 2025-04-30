import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/grupos_defeito/equipamento_dao.dart';
import 'package:sympla_app/core/domain/repositories/equipamento_repository.dart';

class EquipamentoRepositoryImpl implements EquipamentoRepository {
  final DioClient dio;
  final AppDatabase db;
  final EquipamentoDao dao;

  EquipamentoRepositoryImpl({
    required this.dio,
    required this.db,
  }) : dao = db.equipamentoDao;

  @override
  Future<List<EquipamentoTableCompanion>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.equipamentos);
      final dados = response.data as List;

      AppLogger.d('🔍 Recebidos ${dados.length} equipamentos da API',
          tag: 'EquipamentoRepository');

      return dados.map<EquipamentoTableCompanion>((json) {
        return EquipamentoTableCompanion(
          id: Value(json['id']),
          uuid: Value(json['uuid']),
          nome: Value(json['nome']),
          descricao: Value(json['descricao']),
          subestacao: Value(json['subestacao']),
          grupoId: Value(json['grupoId']),
          subgrupoId: Value(json['subgrupoId']),
          createdAt: Value(DateTime.parse(json['createdAt'])),
          updatedAt: Value(DateTime.parse(json['updatedAt'])),
          sincronizado: const Value(true),
        );
      }).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[equipamento_repository_impl - buscarDaApi] ${erro.mensagem}',
          tag: 'EquipamentoRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> salvarNoBanco(
      List<EquipamentoTableCompanion> equipamentos) async {
    try {
      await dao.sincronizarComApi(equipamentos);
      AppLogger.d('💾 Equipamentos salvos no banco local',
          tag: 'EquipamentoRepository');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[equipamento_repository_impl - salvarNoBanco] ${erro.mensagem}',
          tag: 'EquipamentoRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<bool> estaVazio() async {
    return await dao.estaVazio();
  }
}
