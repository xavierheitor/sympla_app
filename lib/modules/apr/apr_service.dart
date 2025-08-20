import 'package:sympla_app/core/core_app/session/session_manager.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_assinatura_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_preenchida_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_question_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_resposta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_table_dto.dart';
import 'package:sympla_app/core/domain/dto/tecnico_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/apr_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/repository_helper.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/tecnico_repository.dart';

/// ✅ Service responsável por orquestrar todas as operações de APR (Análise Preliminar de Risco)
/// Este service centraliza chamadas para o repositório e abstrai a lógica de regras de negócio.
///
/// Toda operação é executada usando o mixin `RepositoryHelper`, que já:
/// 🔸 Faz log de erro
/// 🔸 Faz tratamento de exceções
/// 🔸 Permite retorno seguro em caso de erro
class AprService with RepositoryHelper {
  final AprRepository aprRepository;
  final TecnicoRepository tecnicoRepository;
  final SessionManager session;

  AprService({
    required this.aprRepository,
    required this.tecnicoRepository,
    required this.session,
  });

  /// 🔍 Busca o modelo de APR associado ao tipo de atividade.
  ///
  /// [tipoAtividadeId] → UUID do tipo de atividade.
  /// Retorna o modelo de APR (`AprTableDto`).
  Future<AprTableDto> buscarAprPorTipoAtividade(String tipoAtividadeId) {
    return executar('buscarAprPorTipoAtividade', () {
      return aprRepository.buscarModeloPorTipoAtividade(tipoAtividadeId);
    });
  }

  /// 🔍 Busca todas as perguntas relacionadas a um modelo de APR.
  ///
  /// [aprId] → UUID do modelo de APR.
  /// Retorna uma lista de perguntas (`AprQuestionTableDto`).
  Future<List<AprQuestionTableDto>> buscarPerguntas(String aprId) {
    return executar(
      'buscarPerguntas',
      () => aprRepository.buscarPerguntasRelacionadas(aprId),
      onErrorReturn: [],
    );
  }

  /// 💾 Salva uma lista de respostas preenchidas no banco.
  ///
  /// [respostas] → Lista de respostas (`AprRespostaTableDto`).
  /// Retorna true se salvou com sucesso, false se houve erro.
  Future<bool> salvarRespostas(List<AprRespostaTableDto> respostas) {
    return executar(
      'salvarRespostas',
      () => aprRepository.salvarRespostas(respostas),
      onErrorReturn: false,
    );
  }

  /// 🔍 Verifica se já existe uma APR preenchida para a atividade.
  ///
  /// [atividadeId] → UUID da atividade.
  /// Retorna true se já existe, false se não existe.
  Future<bool> aprJaPreenchida(String atividadeId) {
    return executar('aprJaPreenchida', () async {
      final apr = await aprRepository.buscarAprPreenchida(atividadeId);
      if (apr == null || apr.id == null) return false;

      // 🔍 Verificação dupla: APR preenchida + respostas salvas
      final respostas = await aprRepository.buscarRespostas(apr.id!);
      return respostas.isNotEmpty;
    }, onErrorReturn: false);
  }

  /// 🆕 Cria um registro de APR preenchida para uma atividade.
  ///
  /// [atividadeId] → UUID da atividade.
  /// [aprId] → UUID do modelo de APR.
  /// Retorna o ID da APR preenchida criada.
  Future<int> criarAprPreenchida(String atividadeId, String aprId) {
    return executar('criarAprPreenchida', () {
      final dto = AprPreenchidaTableDto(
        atividadeId: atividadeId,
        aprId: aprId,
        dataPreenchimento: DateTime.now(),
        usuarioId: session.usuario!.uuid,
      );
      return aprRepository.criarAprPreenchida(dto);
    });
  }

  /// 🔄 Atualiza a data de preenchimento de uma APR preenchida.
  ///
  /// [aprPreenchidaId] → ID da APR preenchida.
  /// [dataFinal] → Data a ser salva.
  Future<void> atualizarDataPreenchimentoAprPreenchida(
      int aprPreenchidaId, DateTime dataFinal) {
    return executar('atualizarDataPreenchimentoAprPreenchida', () {
      return aprRepository.atualizarDataPreenchimento(
          aprPreenchidaId, dataFinal);
    });
  }

  /// 🗑️ Deleta uma APR preenchida.
  ///
  /// [aprPreenchidaId] → ID da APR preenchida.
  Future<void> deletarAprPreenchida(int aprPreenchidaId) {
    return executar('deletarAprPreenchida', () {
      return aprRepository.deletarAprPreenchida(aprPreenchidaId);
    });
  }

  /// 🔍 Busca todas as assinaturas relacionadas a uma APR preenchida.
  ///
  /// [aprPreenchidaId] → ID da APR preenchida.
  /// Retorna uma lista de assinaturas (`AprAssinaturaTableDto`).
  Future<List<AprAssinaturaTableDto>> buscarAssinaturas(int aprPreenchidaId) {
    return executar(
      'buscarAssinaturas',
      () => aprRepository.buscarAssinaturas(aprPreenchidaId),
      onErrorReturn: [],
    );
  }

  /// ✍️ Salva uma nova assinatura para uma APR preenchida.
  ///
  /// [assinatura] → Objeto `AprAssinaturaTableDto`.
  Future<void> salvarAssinatura(AprAssinaturaTableDto assinatura) {
    return executar('salvarAssinatura', () {
      return aprRepository.salvarAssinatura(assinatura);
    });
  }

  /// 🔍 Busca todos os técnicos do banco local.
  ///
  /// Útil para preenchimento do campo de assinatura.
  /// Retorna uma lista de técnicos (`TecnicoTableDto`).
  Future<List<TecnicoTableDto>> buscarTecnicos() {
    return executar(
      'buscarTecnicos',
      () => tecnicoRepository.buscarTodosTecnicos(),
      onErrorReturn: [],
    );
  }
}
