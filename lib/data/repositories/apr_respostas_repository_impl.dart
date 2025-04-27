import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/apr_resposta_dao.dart';
import 'package:sympla_app/domain/repositories/apr_respostas_repository.dart';

class AprRespostasRepositoryImpl implements AprRespostasRepository {
  final AprRespostaDao dao;

  AprRespostasRepositoryImpl({required this.dao});

  @override
  Future<bool> salvarRespostas(
      List<AprRespostaTableCompanion> aprRespostas) async {
    try {
      await dao.inserirOuAtualizarTodas(aprRespostas);
      return true;
    } catch (e) {
      AppLogger.e('[AprRespostasRepositoryImpl] Erro ao salvar respostas',
          error: e);
      return false;
    }
  }

  @override
  Future<bool> existeRespostas(int idAtividade) async {
    try {
      final count = await dao.buscarPorAprPreenchida(idAtividade);
      return count.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<AprRespostaTableData>> buscarRespostas(
      int aprPreenchidaId) async {
    try {
      final result = await dao.buscarPorAprPreenchida(aprPreenchidaId);
      return result;
    } catch (_) {
      return [];
    }
  }
}
