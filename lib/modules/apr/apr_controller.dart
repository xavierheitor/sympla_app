// === apr_controller.dart ===
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
import 'package:sympla_app/modules/apr/apr_service.dart';
import 'package:sympla_app/core/storage/converters/resposta_apr_converter.dart';

class AprController extends GetxController {
  final AprService aprService;
  final AtividadeController atividadeController;

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
      if (await aprService.aprJaPreenchida(atividadeId!)) {
        await atividadeController.avancar();
        return;
      }
      aprSelecionada = await aprService.buscarAprPorTipoAtividade(
        atividadeController.atividadeEmAndamento.value!.tipoAtividadeId,
      );
      await _prepararFormulario();
    } catch (e, s) {
      _tratarErro('[onInit]', e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _prepararFormulario() async {
    try {
      final perguntasCarregadas =
          await aprService.buscarPerguntas(aprSelecionada!.uuid);
      perguntas.assignAll(perguntasCarregadas);

      aprPreenchidaId = await aprService.criarAprPreenchida(
          atividadeId!, aprSelecionada!.uuid);

      final respostasIniciais = perguntas
          .map((p) => AprRespostaTableDto(
                perguntaId: p.uuid,
                resposta: null,
                aprPreenchidaId: aprPreenchidaId!,
              ))
          .toList();
      respostasFormulario.assignAll(respostasIniciais);

      await carregarTecnicos();
    } catch (e, s) {
      _tratarErro('[prepararFormulario]', e, s);
    }
  }

  Future<void> salvarRespostas() async {
    try {
      isLoading.value = true;
      final respostasValidas = respostasFormulario.map((r) {
        if (r.resposta == null) {
          AppLogger.e('Pergunta ${r.perguntaId} sem resposta!');
          _tratarErro(
              '[salvarRespostas]',
              Exception('Pergunta ${r.perguntaId} sem resposta!'),
              StackTrace.current);
        }
        return r;
      }).toList();

      if (await aprService.salvarRespostas(respostasValidas)) {
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

  Future<void> carregarAssinaturas() async {
    try {
      if (aprPreenchidaId != null) {
        final assinaturasData =
            await aprService.buscarAssinaturas(aprPreenchidaId!);
        assinaturas.assignAll(assinaturasData);
      }
    } catch (e, s) {
      _tratarErro('[carregarAssinaturas]', e, s);
    }
  }

  Future<void> carregarTecnicos() async {
    try {
      tecnicos.assignAll(await aprService.buscarTecnicos());
    } catch (e, s) {
      _tratarErro('[carregarTecnicos]', e, s);
    }
  }

  void atualizarResposta(String perguntaId, RespostaApr? resposta,
      {String? observacao}) {
    final index =
        respostasFormulario.indexWhere((r) => r.perguntaId == perguntaId);
    if (index != -1) {
      respostasFormulario[index] = AprRespostaTableDto(
        perguntaId: perguntaId,
        resposta: resposta!,
        aprPreenchidaId: aprPreenchidaId!,
        observacao: observacao ?? respostasFormulario[index].observacao,
      );
    }
  }

  Future<void> apagarAprPreenchidaSeNaoSalvou() async {
    try {
      if (aprPreenchidaId != null && !salvouFormulario) {
        await aprService.deletarAprPreenchida(aprPreenchidaId!);
      }
    } catch (e, s) {
      _tratarErro('[apagarAprPreenchidaSeNaoSalvou]', e, s);
    }
  }

  bool podeSalvar() {
    final preenchidas =
        respostasFormulario.where((r) => r.resposta != null).length;
    return preenchidas == perguntas.length && assinaturas.length >= 2;
  }

  void _tratarErro(String contexto, Object e, StackTrace s) {
    final erro = ErrorHandler.tratar(e, s);
    AppLogger.e('$contexto ${erro.mensagem}',
        tag: 'AprController', error: e, stackTrace: s);
    Get.snackbar('Erro', erro.mensagem,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError);
  }
}
