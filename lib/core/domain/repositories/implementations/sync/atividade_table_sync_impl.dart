import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/atividade_dao.dart';

class AtividadeTableSyncImpl implements SyncableRepository<AtividadeTableDto> {
  final AppDatabase db;
  final DioClient dio;
  final AtividadeDao atividadeDao;

  AtividadeTableSyncImpl(
    this.db,
    this.dio,
  ) : atividadeDao = db.atividadeDao;

  @override
  Future<List<AtividadeTableDto>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.atividades);
      for (var json in response.data) {
        try {
          final dto = AtividadeTableDto.fromJson(json);
          AppLogger.d('✅ Atividade convertida: ${dto.uuid}');
        } catch (e, s) {
          AppLogger.e('❌ Erro ao converter atividade: $json',
              error: e, stackTrace: s);
        }
      }
      return (response.data as List)
          .map((e) => AtividadeTableDto.fromJson(e))
          .toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[atividade_table_sync_impl - buscarDaApi] ${erro.mensagem}',
        tag: 'AtividadeTableSyncImpl',
        error: e,
        stackTrace: s,
      );
      return [];
    }
  }

  @override
  Future<bool> estaVazio(String entidade) async {
    try {
      return await atividadeDao.estaVazioAtividade();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[atividade_table_sync_impl - estaVazio] ${erro.mensagem}',
        tag: 'AtividadeTableSyncImpl',
        error: e,
        stackTrace: s,
      );
      return true;
    }
  }
  @override
Future<void> sincronizarComBanco(List<AtividadeTableDto> itens) async {
    try {
      AppLogger.d('🌀 Buscando atividades da API...');
      final data = await buscarDaApi();

      AppLogger.d('🔄 Convertendo para companions...');
      final companions = data.map((e) => e.toCompanion()).toList();

      AppLogger.d('📥 Inserindo no banco (${companions.length} registros)...');
      await atividadeDao.sincronizarAtividadesComApi(companions);

      AppLogger.d('✅ Sincronização de atividades concluída com sucesso.');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[atividade_table_sync_impl - sincronizarComBanco] ${erro.mensagem}',
        error: e,
        stackTrace: s,
      );
    }
  }
  @override
  String get nomeEntidade => 'atividade';
}
