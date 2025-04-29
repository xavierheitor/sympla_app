import 'package:sympla_app/core/domain/repositories/tecnicos_repository.dart';
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
  final TecnicosRepository tecnicosRepository;

  AprService({
    required this.aprRepository,
    required this.aprPerguntasRepository,
    required this.aprRespostasRepository,
    required this.tecnicosRepository,
  });

  Future<AprTableData> buscarAprPorTipoAtividade(int idTipoAtividade) async {
    try {
      AppLogger.d(
          '🔍 [AprService] Buscando APR para tipoAtividade: $idTipoAtividade',
          tag: 'AprService');
      final apr = await aprRepository.buscarPorTipoAtividade(idTipoAtividade);
      AppLogger.d(
          '✅ [AprService] APR encontrada - ID: ${apr.id}, Nome: ${apr.nome}',
          tag: 'AprService');
      return apr;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - buscarAprPorTipoAtividade] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<AprQuestionTableData>> buscarPerguntas(int aprId) async {
    try {
      AppLogger.d('🔍 [AprService] Buscando perguntas para APR: $aprId',
          tag: 'AprService');
      final perguntas = await aprPerguntasRepository.buscarTodos(aprId);
      AppLogger.d(
          '✅ [AprService] ${perguntas.length} perguntas encontradas para APR $aprId',
          tag: 'AprService');
      AppLogger.d(
          '📋 [AprService] IDs das perguntas: ${perguntas.map((p) => p.id).join(', ')}',
          tag: 'AprService');
      return perguntas;
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
      AppLogger.d(
          '💾 [AprService] Iniciando salvamento de ${respostas.length} respostas',
          tag: 'AprService');
      AppLogger.d(
          '📋 [AprService] IDs das perguntas: ${respostas.map((r) => r.perguntaId.value).join(', ')}',
          tag: 'AprService');
      final sucesso = await aprRespostasRepository.salvarRespostas(respostas);
      AppLogger.d('✅ [AprService] Respostas salvas com sucesso: $sucesso',
          tag: 'AprService');
      return sucesso;
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
          '🔍 [AprService] Verificando se atividade $atividadeId já tem APR preenchida',
          tag: 'AprService');
      final existe = await aprRespostasRepository.existeRespostas(atividadeId);
      AppLogger.d(
          '📊 [AprService] APR ${existe ? "já preenchida" : "não preenchida"} para atividade $atividadeId',
          tag: 'AprService');
      return existe;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - aprJaPreenchida] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<TecnicosTableData>> buscarTecnicos() async {
    try {
      AppLogger.d('🔍 [AprService] Buscando técnicos', tag: 'AprService');
      final tecnicos = await tecnicosRepository.buscarTodos();
      AppLogger.d('✅ [AprService] ${tecnicos.length} técnicos encontrados',
          tag: 'AprService');
      return tecnicos;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - buscarTecnicos] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }
}
