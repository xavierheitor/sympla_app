import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/apr_resposta_dao.dart';
import 'package:sympla_app/domain/repositories/apr_respostas_repository.dart';

class AprRespostasRepositoryImpl implements AprRespostasRepository {
  final AprRespostaDao dao;

  AprRespostasRepositoryImpl({required this.dao});

  @override
  Future<bool> salvarRespostas(
      int idAprPreenchida, List<AprRespostaTableCompanion> aprRespostas) async {
    try {
      for (final resposta in aprRespostas) {
        await dao.inserirOuAtualizar(resposta);
      }
      return true;
    } catch (_) {
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
