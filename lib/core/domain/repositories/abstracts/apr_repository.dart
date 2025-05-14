import 'package:sympla_app/core/domain/dto/apr/apr_assinatura_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_preenchida_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_question_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_resposta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_table_dto.dart';

abstract class AprRepository {
  // --------------------- APR ---------------------
  Future<AprTableDto> buscarModeloPorTipoAtividade(String idTipoAtividade);

  // --------------------- Perguntas ---------------------
  Future<List<AprQuestionTableDto>> buscarPerguntasRelacionadas(String aprId);

  // --------------------- APR Preenchida ---------------------
  Future<int> criarAprPreenchida(AprPreenchidaTableDto apr);
  Future<void> atualizarDataPreenchimento(int aprPreenchidaId, DateTime data);
  Future<void> deletarAprPreenchida(int aprPreenchidaId);
  Future<bool> existeAprPreenchida(String atividadeId);
  Future<AprPreenchidaTableDto?> buscarAprPreenchida(String atividadeId);

  // --------------------- Respostas ---------------------
  Future<bool> salvarRespostas(List<AprRespostaTableDto> respostas);
  Future<List<AprRespostaTableDto>> buscarRespostas(int aprPreenchidaId);
  Future<void> deletarRespostas(int aprPreenchidaId);
  Future<bool> existeRespostas(int aprPreenchidaId);

  // --------------------- Assinaturas ---------------------
  Future<void> salvarAssinatura(AprAssinaturaTableDto assinatura);
  Future<List<AprAssinaturaTableDto>> buscarAssinaturas(int aprPreenchidaId);
  Future<int> contarAssinaturas(int aprPreenchidaId);
  Future<void> deletarAssinaturas(int aprPreenchidaId);
}
