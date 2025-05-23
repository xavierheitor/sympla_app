import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/core_app/session/session_manager.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_assinatura_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_question_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_resposta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_table_dto.dart';
import 'package:sympla_app/core/domain/dto/tecnico_table_dto.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/converters/resposta_apr_converter.dart';
import 'package:sympla_app/modules/apr/apr_service.dart';

class AprController extends GetxController {
  final AprService aprService;
  final AtividadeController atividadeController;

  // 🔄 Estados observáveis
  final RxBool isLoading = false.obs;
  final RxList<AprQuestionTableDto> perguntas = <AprQuestionTableDto>[].obs;
  final RxList<AprRespostaTableDto> respostasFormulario =
      <AprRespostaTableDto>[].obs;
  final RxList<AprAssinaturaTableDto> assinaturas =
      <AprAssinaturaTableDto>[].obs;
  final RxList<TecnicoTableDto> tecnicos = <TecnicoTableDto>[].obs;

  // 🔑 Controle do estado atual
  AprTableDto? aprSelecionada;
  String? atividadeId;
  int? aprPreenchidaId;
  bool salvouFormulario = false;

  AprController({
    required this.aprService,
    required this.atividadeController,
  });

  @override
  Future<void> onInit() async {
    super.onInit();
    atividadeId = atividadeController.atividadeEmAndamento.value?.uuid;
    if (atividadeId == null) return;

    try {
      isLoading.value = true;

      // 🚫 Se já foi preenchida, avança para a próxima etapa
      if (await aprService.aprJaPreenchida(atividadeId!)) {
        await atividadeController.avancar();
        return;
      }

      // 🔍 Carrega modelo APR e inicializa formulário
      aprSelecionada = await aprService.buscarAprPorTipoAtividade(
          atividadeController.atividadeEmAndamento.value!.tipoAtividadeId);
      await _prepararFormulario();
    } catch (e, s) {
      _tratarErro('[onInit]', e, s);
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔧 Prepara o formulário inicial de perguntas, respostas e técnicos
  Future<void> _prepararFormulario() async {
    try {
      perguntas
          .assignAll(await aprService.buscarPerguntas(aprSelecionada!.uuid));

      aprPreenchidaId = await aprService.criarAprPreenchida(
          atividadeId!, aprSelecionada!.uuid);

      respostasFormulario.assignAll(perguntas.map(
        (p) => AprRespostaTableDto(
          perguntaId: p.uuid,
          aprPreenchidaId: aprPreenchidaId!,
          resposta: null,
        ),
      ));

      await carregarTecnicos();
    } catch (e, s) {
      _tratarErro('[prepararFormulario]', e, s);
    }
  }

  /// 💾 Salva respostas e avança se tudo estiver preenchido corretamente
  Future<void> salvarRespostas() async {
    try {
      isLoading.value = true;

      final respostasValidas =
          respostasFormulario.where((r) => r.resposta != null).toList();

      if (respostasValidas.length != perguntas.length) {
        throw Exception('Existem perguntas não respondidas');
      }

      final sucesso = await aprService.salvarRespostas(respostasValidas);

      if (sucesso) {
        await aprService.atualizarDataPreenchimentoAprPreenchida(
            aprPreenchidaId!, DateTime.now());
        salvouFormulario = true;
        await atividadeController.avancar();
      }
    } catch (e, s) {
      _tratarErro('[salvarRespostas]', e, s);
    } finally {
      isLoading.value = false;
    }
  }

  /// ✍️ Adiciona uma assinatura vinculada ao técnico
  Future<void> adicionarAssinatura(
      Uint8List assinaturaBytes, String tecnicoId) async {
    try {
      await aprService.salvarAssinatura(
        AprAssinaturaTableDto(
          aprPreenchidaId: aprPreenchidaId!,
          assinatura: assinaturaBytes,
          dataAssinatura: DateTime.now(),
          usuarioId: Get.find<SessionManager>().usuario!.uuid,
          tecnicoId: tecnicoId,
        ),
      );
      await carregarAssinaturas();
    } catch (e, s) {
      _tratarErro('[adicionarAssinatura]', e, s);
    }
  }

  /// 🔄 Carrega assinaturas vinculadas à APR preenchida
  Future<void> carregarAssinaturas() async {
    try {
      if (aprPreenchidaId != null) {
        assinaturas
            .assignAll(await aprService.buscarAssinaturas(aprPreenchidaId!));
      }
    } catch (e, s) {
      _tratarErro('[carregarAssinaturas]', e, s);
    }
  }

  /// 🔄 Carrega os técnicos cadastrados no banco
  Future<void> carregarTecnicos() async {
    try {
      tecnicos.assignAll(await aprService.buscarTecnicos());
    } catch (e, s) {
      _tratarErro('[carregarTecnicos]', e, s);
    }
  }

  /// ✏️ Atualiza uma resposta específica no formulário
  void atualizarResposta(String perguntaId, RespostaApr? resposta,
      {String? observacao}) {
    final index =
        respostasFormulario.indexWhere((r) => r.perguntaId == perguntaId);
    if (index == -1) return;

    respostasFormulario[index] = respostasFormulario[index]
        .copyWith(resposta: resposta, observacao: observacao);
  }

  /// 🗑️ Deleta a APR preenchida se o formulário não foi salvo (cancelamento)
  Future<void> apagarAprPreenchidaSeNaoSalvou() async {
    try {
      if (aprPreenchidaId != null && !salvouFormulario) {
        await aprService.deletarAprPreenchida(aprPreenchidaId!);
      }
    } catch (e, s) {
      _tratarErro('[apagarAprPreenchidaSeNaoSalvou]', e, s);
    }
  }

  /// ✔️ Valida se pode salvar (todas as respostas preenchidas + mínimo de 2 assinaturas)
  bool podeSalvar() {
    final respostasPreenchidas =
        respostasFormulario.where((r) => r.resposta != null).length;
    return respostasPreenchidas == perguntas.length && assinaturas.length >= 2;
  }

  /// 🚨 Tratamento de erro genérico e exibição de snackbar
  void _tratarErro(String contexto, Object e, StackTrace s) {
    final erro = ErrorHandler.tratar(e, s);
    AppLogger.e('$contexto ${erro.mensagem}',
        tag: 'AprController', error: e, stackTrace: s);

    Get.snackbar(
      'Erro',
      erro.mensagem,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
    );
  }
}
