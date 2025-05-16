import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_question_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_assinatura_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_resposta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_table_dto.dart';
import 'package:sympla_app/core/domain/dto/tecnico_table_dto.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/modules/apr/apr_service.dart';
import 'package:sympla_app/core/core_app/session/session_manager.dart';
import 'package:sympla_app/core/storage/converters/resposta_apr_converter.dart';
// ... imports mantidos

class AprController extends GetxController {
  final AprService aprService;
  final AtividadeController atividadeController;

  AprController({
    required this.aprService,
    required this.atividadeController,
  });

  final RxBool isLoading = false.obs;
  final RxList<AprQuestionTableDto> perguntas = <AprQuestionTableDto>[].obs;
  final RxList<AprRespostaTableDto> respostasFormulario =
      <AprRespostaTableDto>[].obs;
  final RxList<AprAssinaturaTableDto> assinaturas =
      <AprAssinaturaTableDto>[].obs;
  final RxList<TecnicoTableDto> tecnicos = <TecnicoTableDto>[].obs;

  AprTableDto? aprSelecionada;
  String? atividadeId;
  int? aprPreenchidaId;
  bool salvouFormulario = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    AppLogger.d('🎯 [AprController] onInit chamado');

    //pega a atividade em andamento
    final atividade = atividadeController.atividadeEmAndamento.value;

    //verifica se a atividade em andamento esta vazia
    if (atividade == null) {
      AppLogger.w(
          '⚠️ [AprController] Nenhuma atividade em andamento encontrada');
      return;
    }

    //pega o id da atividade em andamento
    atividadeId = atividade.uuid;
    AppLogger.d(
        'ℹ️ [AprController] ID da atividade em andamento: $atividadeId');

    //tenta carregar a apr
    try {
      isLoading.value = true;

      //verifica se a apr ja esta preenchida
      final jaPreenchida = await aprService.aprJaPreenchida(atividadeId!);
      AppLogger.d(
          'ℹ️ [AprController] Resultado de aprJaPreenchida: $jaPreenchida');

      if (jaPreenchida) {
        AppLogger.d(
            '✅ [AprController] APR já preenchida. Chamando atividadeController.avancar()');
        //avanca para a proxima etapa
        await atividadeController.avancar();
        return;
      }

      //cria a apr preenchida primeiro
      await criarAprPreenchida();
      //carrega a apr depois
      await carregarApr();

      //carrega os tecnicos
      await carregarTecnicos();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprController - onInit] ${erro.mensagem}',
          tag: 'AprController', error: e, stackTrace: s);
      Get.snackbar('Erro', erro.mensagem,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    AppLogger.d('🧹 [AprController] onClose chamado');

    //apaga a apr preenchida se nao salvou
    apagarAprPreenchidaSeNaoSalvou();

    //fecha o controller
    super.onClose();
  }

  Future<void> carregarApr() async {
    //pega a atividade em andamento
    final atividade = atividadeController.atividadeEmAndamento.value;

    //verifica se a atividade em andamento esta vazia
    if (atividade == null) {
      AppLogger.w(
          '⚠️ [AprController] Nenhuma atividade disponível para carregar APR');
      return;
    }

    //pega o id da atividade em andamento
    atividadeId = atividade.uuid;

    //tenta carregar a apr
    try {
      AppLogger.d(
          '🔄 [AprController] Carregando APR para tipoAtividadeId=${atividade.tipoAtividadeId}');
      isLoading.value = true;

      aprSelecionada =
          await aprService.buscarAprPorTipoAtividade(atividade.tipoAtividadeId);
      AppLogger.d(
          '✅ [AprController] APR selecionada: id=${aprSelecionada!.uuid}, nome=${aprSelecionada!.nome}');

      final perguntasCarregadas =
          await aprService.buscarPerguntas(aprSelecionada!.uuid);
      perguntas.assignAll(perguntasCarregadas as Iterable<AprQuestionTableDto>);
      AppLogger.d(
          '📋 [AprController] Perguntas carregadas: ${perguntas.length}');

      final respostasIniciais = perguntas
          .map((p) => AprRespostaTableDto(
                perguntaId: p.uuid,
                resposta: null,
                aprPreenchidaId: aprPreenchidaId!,
              ))
          .toList();
      respostasFormulario.assignAll(respostasIniciais);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprController - carregarApr] ${erro.mensagem}',
          tag: 'AprController', error: e, stackTrace: s);
      Get.snackbar('Erro', erro.mensagem,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError);
    } finally {
      isLoading.value = false;
    }
  }

  //atualiza a resposta da pergunta
  void atualizarResposta(String perguntaId, RespostaApr? resposta,
      {String? observacao}) {
    final index =
        respostasFormulario.indexWhere((r) => r.perguntaId == perguntaId);
    if (index != -1) {
      AppLogger.d('✏️ Atualizando resposta da perguntaId=$perguntaId');
      respostasFormulario[index] = AprRespostaTableDto(
        perguntaId: perguntaId,
        resposta: resposta!,
        aprPreenchidaId: aprPreenchidaId!,
        observacao: observacao ?? respostasFormulario[index].observacao,
      );
    }
  }

  //salva as respostas
  Future<void> salvarRespostas() async {
    try {
      AppLogger.d('💾 [AprController] Salvando respostas...');
      isLoading.value = true;

      final respostasParaSalvar = respostasFormulario.map((r) {
        if (r.resposta == null) {
          throw Exception('Pergunta ${r.perguntaId} sem resposta!');
        }
        return AprRespostaTableDto(
          perguntaId: r.perguntaId,
          resposta: r.resposta!,
          aprPreenchidaId: aprPreenchidaId!,
          observacao: r.observacao,
        );
      }).toList();

      AppLogger.d(
          '📤 [AprController] Total de respostas válidas: ${respostasParaSalvar.length}');

      final sucesso = await aprService.salvarRespostas(respostasParaSalvar);

      if (sucesso && aprPreenchidaId != null) {
        AppLogger.d(
            '✅ [AprController] Respostas salvas. Atualizando data preenchimento...');
        await aprService.atualizarDataPreenchimentoAprPreenchida(
          aprPreenchidaId!,
          DateTime.now(),
        );
        salvouFormulario = true;

        //avanca para a proxima etapa
        await atividadeController.avancar();
      }
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprController - salvarRespostas] ${erro.mensagem}',
          tag: 'AprController', error: e, stackTrace: s);
      Get.snackbar('Erro', erro.mensagem,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError);
    } finally {
      isLoading.value = false;
    }
  }

  //adiciona a assinatura
  Future<void> adicionarAssinatura(
      Uint8List assinaturaBytes, String tecnicoId) async {
    try {
      if (aprPreenchidaId == null) {
        throw Exception('APR preenchida ainda não criada');
      }

      AppLogger.d(
          '🖋️ [AprController] Salvando assinatura para técnico $tecnicoId');

      final assinatura = AprAssinaturaTableDto(
        aprPreenchidaId: aprPreenchidaId!,
        assinatura: assinaturaBytes,
        dataAssinatura: DateTime.now(),
        usuarioId: Get.find<SessionManager>().usuario!.uuid,
        tecnicoId: tecnicoId,
      );

      await aprService.salvarAssinatura(assinatura);
      await carregarAssinaturas();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprController - adicionarAssinatura] ${erro.mensagem}',
          tag: 'AprController', error: e, stackTrace: s);
      Get.snackbar('Erro', erro.mensagem,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError);
    }
  }

  //carrega as assinaturas
  Future<void> carregarAssinaturas() async {
    if (aprPreenchidaId == null) return;

    try {
      AppLogger.d(
          '📥 [AprController] Buscando assinaturas da APR $aprPreenchidaId');
      final assinaturasData =
          await aprService.buscarAssinaturas(aprPreenchidaId!);
      assinaturas.assignAll(
        assinaturasData.map((a) => AprAssinaturaTableDto(
              assinatura: a.assinatura,
              tecnicoId: a.tecnicoId,
              aprPreenchidaId: aprPreenchidaId!,
              dataAssinatura: a.dataAssinatura,
              usuarioId: a.usuarioId,
            )),
      );
      AppLogger.d(
          '✅ [AprController] ${assinaturas.length} assinaturas carregadas');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprController - carregarAssinaturas] ${erro.mensagem}',
          tag: 'AprController', error: erro.mensagem, stackTrace: erro.stack);
    }
  }

  //carrega os tecnicos
  Future<void> carregarTecnicos() async {
    try {
      AppLogger.d('👷 [AprController] Carregando técnicos disponíveis...');
      final tecnicosData = await aprService.buscarTecnicos();
      tecnicos.assignAll(tecnicosData);
      AppLogger.d('✅ [AprController] Técnicos carregados: ${tecnicos.length}');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprController - carregarTecnicos] ${erro.mensagem}',
          tag: 'AprController', error: erro.mensagem, stackTrace: erro.stack);
    }
  }

  //cria a apr preenchida
  Future<void> criarAprPreenchida() async {
    if (atividadeId == null || aprSelecionada == null) return;

    try {
      AppLogger.d('📄 [AprController] Criando APR preenchida...');
      aprPreenchidaId = await aprService.criarAprPreenchida(
        atividadeId!,
        aprSelecionada!.uuid,
      );
      AppLogger.d(
          '✅ [AprController] APR preenchida criada com ID $aprPreenchidaId');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprController - criarAprPreenchida] ${erro.mensagem}',
          tag: 'AprController', error: e, stackTrace: s);
      Get.snackbar('Erro ao preparar APR', erro.mensagem,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError);
    }
  }

  //apaga a apr preenchida se nao salvou
  Future<void> apagarAprPreenchidaSeNaoSalvou() async {
    try {
      if (aprPreenchidaId != null && !salvouFormulario) {
        AppLogger.d(
            '🧽 [AprController] Deletando rascunho da APR preenchida $aprPreenchidaId');
        await aprService.deletarAprPreenchida(aprPreenchidaId!);
        AppLogger.d('✅ [AprController] Rascunho da APR apagado');
      }
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AprController - apagarAprPreenchidaSeNaoSalvou] ${erro.mensagem}',
          tag: 'AprController',
          error: erro.mensagem,
          stackTrace: erro.stack);
    }
  }

  //verifica se pode salvar - trava do botao de salvar
  bool podeSalvar() {
    final respostasPreenchidas =
        respostasFormulario.where((r) => r.resposta != null).length;
    final quantidadeAssinatura = assinaturas.length;

    AppLogger.d(
        '📊 [AprController] Validação antes de salvar: Respostas = $respostasPreenchidas / ${perguntas.length}, Assinaturas = $quantidadeAssinatura');

    return respostasPreenchidas == perguntas.length &&
        quantidadeAssinatura >= 2;
  }
}
