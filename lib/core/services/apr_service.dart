import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/domain/repositories/apr_perguntas_repository.dart';
import 'package:sympla_app/core/domain/repositories/apr_repository.dart';
import 'package:sympla_app/core/domain/repositories/apr_respostas_repository.dart';

class AprService {
  final AprRepository aprRepository;
  final AprPerguntasRepository aprPerguntasRepository;
  final AprRespostasRepository aprRespostasRepository;

  AprService({
    required this.aprRepository,
    required this.aprPerguntasRepository,
    required this.aprRespostasRepository,
  });

  Future<AprTableData> buscarAprPorTipoAtividade(int idTipoAtividade) async {
    try {
      AppLogger.d('🔍 Buscando APR para tipoAtividade: $idTipoAtividade',
          tag: 'AprService');
      return await aprRepository.buscarPorTipoAtividade(idTipoAtividade);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - buscarAprPorTipoAtividade] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<AprQuestionTableData>> buscarPerguntas(int aprId) async {
    try {
      AppLogger.d('🔍 Buscando perguntas para APR: $aprId', tag: 'AprService');
      return await aprPerguntasRepository.buscarTodos(aprId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - buscarPerguntas] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<bool> salvarRespostas(
      List<AprRespostaTableCompanion> respostas) async {
    try {
      AppLogger.d('💾 Salvando ${respostas.length} respostas da APR',
          tag: 'AprService');
      return await aprRespostasRepository.salvarRespostas(respostas);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - salvarRespostas] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<bool> aprJaPreenchida(int atividadeId) async {
    try {
      AppLogger.d(
          '🔍 Verificando se atividade $atividadeId já tem APR preenchida',
          tag: 'AprService');
      return await aprRespostasRepository.existeRespostas(atividadeId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - aprJaPreenchida] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }
}
