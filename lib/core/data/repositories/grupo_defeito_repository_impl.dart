import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/domain/repositories/grupo_defeito_repository.dart';
import 'package:sympla_app/core/storage/daos/checklist/grupo_defeito_equipamento_dao.dart';

class GrupoDefeitoRepositoryImpl implements GrupoDefeitoRepository {
  final DioClient dio;
  final AppDatabase db;
  final GrupoDefeitoEquipamentoDao dao;

  GrupoDefeitoRepositoryImpl({
    required this.dio,
    required this.db,
  }) : dao = db.grupoDefeitoEquipamentoDao;

  @override
  Future<List<GrupoDefeitoEquipamentoTableCompanion>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.gruposDefeito);
      final dados = response.data as List;

      return dados.map<GrupoDefeitoEquipamentoTableCompanion>((json) {
        return GrupoDefeitoEquipamentoTableCompanion(
          id: Value(json['id'] ?? 0),
          uuid: Value(json['uuid'] ?? ''),
          nome: Value(json['nome'] ?? ''),
          createdAt: Value(DateTime.parse(json['createdAt'] ?? '')),
          updatedAt: Value(DateTime.parse(json['updatedAt'] ?? '')),
          sincronizado: const Value(true),
        );
      }).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[grupo_defeito_repository_impl - buscarDaApi] ${erro.mensagem}',
          tag: 'GrupoDefeitoRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> salvarNoBanco(
      List<GrupoDefeitoEquipamentoTableCompanion> dados) async {
    try {
      await dao.sincronizarComApi(dados);
      AppLogger.d('💾 Grupos de defeito salvos no banco local',
          tag: 'GrupoDefeitoRepo');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[grupo_defeito_repository_impl - salvarNoBanco] ${erro.mensagem}',
          tag: 'GrupoDefeitoRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<bool> estaVazio() async {
    // return await dao.estaVazio();
    return true;
  }
}
