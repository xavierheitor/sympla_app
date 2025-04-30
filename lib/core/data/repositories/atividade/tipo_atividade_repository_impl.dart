import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/atividade/tipo_atividade_dao.dart';
import 'package:sympla_app/core/domain/repositories/atividade/tipo_atividade_repository.dart';
import 'package:sympla_app/core/storage/converters/tipo_atividade_mobile_converter.dart';

class TipoAtividadeRepositoryImpl implements TipoAtividadeRepository {
  final DioClient dio;
  final TipoAtividadeDao dao;
  final AppDatabase db;

  TipoAtividadeRepositoryImpl({
    required this.dio,
    required this.db,
  }) : dao = db.tipoAtividadeDao;

  @override
  Future<List<TipoAtividadeTableCompanion>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.tipoAtividade);
      final dados = response.data as List;

      AppLogger.d('🔍 Recebidos ${dados.length} tipos de atividade da API',
          tag: 'TipoAtividadeRepo');

      return dados.map<TipoAtividadeTableCompanion>((json) {
        return TipoAtividadeTableCompanion(
          id: Value(json['id']),
          uuid: Value(json['uuid']),
          nome: Value(json['nome']),
          tipoAtividadeMobile: Value(
            TipoAtividadeMobile.values.firstWhere(
              (e) => e.name == json['tipoAtividadeMobile'],
              orElse: () => TipoAtividadeMobile.ivItIu,
            ),
          ),
          aprId: Value(json['aprId']),
          checklistId: Value(json['checklistId']),
          createdAt: Value(DateTime.parse(json['createdAt'])),
          updatedAt: Value(DateTime.parse(json['updatedAt'])),
          sincronizado: const Value(true),
        );
      }).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[tipo_atividade_repository_impl - buscarDaApi] ${erro.mensagem}',
          tag: 'TipoAtividadeRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> salvarNoBanco(List<TipoAtividadeTableCompanion> dados) async {
    try {
      await dao.sincronizarComApi(dados);
      AppLogger.d('💾 Tipos de atividade salvos no banco local',
          tag: 'TipoAtividadeRepo');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[tipo_atividade_repository_impl - salvarNoBanco] ${erro.mensagem}',
          tag: 'TipoAtividadeRepositoryImpl',
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
