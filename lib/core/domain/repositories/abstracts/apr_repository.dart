import 'package:sympla_app/core/domain/dto/apr/apr_assinatura_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_preenchida_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_question_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_resposta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_table_dto.dart';

/// 🔗 Contrato para operações relacionadas à APR no banco local.
///
/// Este repository é responsável por fornecer:
/// - Acesso ao modelo de APR
/// - Gerenciamento de preenchimentos, respostas e assinaturas
abstract class AprRepository {
  // --------------------- APR ---------------------

  /// 🔍 Busca o modelo de APR associado a um tipo de atividade.
  Future<AprTableDto> buscarModeloPorTipoAtividade(String tipoAtividadeId);

  /// 🔍 Busca as perguntas relacionadas a uma APR.
  Future<List<AprQuestionTableDto>> buscarPerguntasRelacionadas(String aprId);

  // --------------------- APR Preenchida ---------------------

  /// 🆕 Cria um registro de APR preenchida.
  Future<int> criarAprPreenchida(AprPreenchidaTableDto apr);

  /// 🔄 Atualiza a data de preenchimento da APR.
  Future<void> atualizarDataPreenchimento(int aprPreenchidaId, DateTime data);

  /// ❌ Remove uma APR preenchida.
  Future<void> deletarAprPreenchida(int aprPreenchidaId);

  /// 🔍 Verifica se existe APR preenchida para uma atividade.
  Future<bool> existeAprPreenchida(String atividadeId);

  /// 🔍 Busca a APR preenchida de uma atividade.
  Future<AprPreenchidaTableDto?> buscarAprPreenchida(String atividadeId);

  // --------------------- Respostas ---------------------

  /// 💾 Salva as respostas de uma APR.
  Future<bool> salvarRespostas(List<AprRespostaTableDto> respostas);

  /// 🔍 Busca as respostas associadas a uma APR preenchida.
  Future<List<AprRespostaTableDto>> buscarRespostas(int aprPreenchidaId);

  /// ❌ Deleta as respostas de uma APR preenchida.
  Future<void> deletarRespostas(int aprPreenchidaId);

  /// 🔍 Verifica se existem respostas para uma APR preenchida.
  Future<bool> existeRespostas(int aprPreenchidaId);

  // --------------------- Assinaturas ---------------------

  /// 💾 Salva uma assinatura na APR.
  Future<void> salvarAssinatura(AprAssinaturaTableDto assinatura);

  /// 🔍 Busca as assinaturas da APR preenchida.
  Future<List<AprAssinaturaTableDto>> buscarAssinaturas(int aprPreenchidaId);

  /// 🔢 Conta o número de assinaturas em uma APR preenchida.
  Future<int> contarAssinaturas(int aprPreenchidaId);

  /// ❌ Deleta as assinaturas da APR preenchida.
  Future<void> deletarAssinaturas(int aprPreenchidaId);
}
