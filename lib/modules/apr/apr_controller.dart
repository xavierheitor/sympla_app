import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
import 'package:sympla_app/core/data/models/resposta_formulario.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/modules/apr/apr_service.dart';
import 'package:sympla_app/core/session/session_manager.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:drift/drift.dart' as d;
import 'package:sympla_app/core/storage/converters/resposta_apr_converter.dart';
import 'package:sympla_app/core/data/models/assinatura_model.dart';
// ... imports mantidos

class AprController extends GetxController {
  final AprService aprService;
  final AtividadeController atividadeController;

  AprController({
    required this.aprService,
    required this.atividadeController,
  });

  final RxBool isLoading = false.obs;
  final RxList<AprQuestionTableData> perguntas = <AprQuestionTableData>[].obs;
  final RxList<RespostaFormulario> respostasFormulario =
      <RespostaFormulario>[].obs;
  final RxList<AssinaturaModel> assinaturas = <AssinaturaModel>[].obs;
  final RxList<TecnicosTableData> tecnicos = <TecnicosTableData>[].obs;

  AprTableData? aprSelecionada;
  int? atividadeId;
  int? aprPreenchidaId;
  bool salvouFormulario = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    AppLogger.d('🎯 [AprController] onInit chamado');

    final atividade = atividadeController.atividadeEmAndamento.value;

    if (atividade == null) {
      AppLogger.w(
          '⚠️ [AprController] Nenhuma atividade em andamento encontrada');
      return;
    }

    atividadeId = atividade.id;
    AppLogger.d(
        'ℹ️ [AprController] ID da atividade em andamento: $atividadeId');

    try {
      isLoading.value = true;

      final jaPreenchida = await aprService.aprJaPreenchida(atividadeId!);
      AppLogger.d(
          'ℹ️ [AprController] Resultado de aprJaPreenchida: $jaPreenchida');

      if (jaPreenchida) {
        AppLogger.d(
            '✅ [AprController] APR já preenchida. Chamando atividadeController.avancar()');
        await atividadeController.avancar();
        return;
      }

      await carregarApr();
      await criarAprPreenchida();
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
    apagarAprPreenchidaSeNaoSalvou();
    super.onClose();
  }

  Future<void> carregarApr() async {
    final atividade = atividadeController.atividadeEmAndamento.value;
    if (atividade == null) {
      AppLogger.w(
          '⚠️ [AprController] Nenhuma atividade disponível para carregar APR');
      return;
    }

    atividadeId = atividade.id;

    try {
      AppLogger.d(
          '🔄 [AprController] Carregando APR para tipoAtividadeId=${atividade.tipoAtividadeId}');
      isLoading.value = true;

      aprSelecionada =
          await aprService.buscarAprPorTipoAtividade(atividade.tipoAtividadeId);
      AppLogger.d(
          '✅ [AprController] APR selecionada: id=${aprSelecionada!.id}, nome=${aprSelecionada!.nome}');

      final perguntasCarregadas =
          await aprService.buscarPerguntas(aprSelecionada!.id);
      perguntas.assignAll(perguntasCarregadas);
      AppLogger.d(
          '📋 [AprController] Perguntas carregadas: ${perguntas.length}');

      final respostasIniciais =
          perguntas.map((p) => RespostaFormulario(perguntaId: p.id)).toList();
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

  void atualizarResposta(int perguntaId, RespostaApr? resposta,
      {String? observacao}) {
    final index =
        respostasFormulario.indexWhere((r) => r.perguntaId == perguntaId);
    if (index != -1) {
      AppLogger.d('✏️ Atualizando resposta da perguntaId=$perguntaId');
      respostasFormulario[index] = RespostaFormulario(
        perguntaId: perguntaId,
        resposta: resposta,
        observacao: observacao ?? respostasFormulario[index].observacao,
      );
    }
  }

  Future<void> salvarRespostas() async {
    try {
      AppLogger.d('💾 [AprController] Salvando respostas...');
      isLoading.value = true;

      final respostasParaSalvar = respostasFormulario.map((r) {
        if (r.resposta == null) {
          throw Exception('Pergunta ${r.perguntaId} sem resposta!');
        }
        return AprRespostaTableCompanion(
          perguntaId: d.Value(r.perguntaId),
          resposta: d.Value(r.resposta!),
          aprPreenchidaId: d.Value(aprPreenchidaId!),
          observacao: d.Value(r.observacao),
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

  Future<void> adicionarAssinatura(
      Uint8List assinaturaBytes, int tecnicoId) async {
    try {
      if (aprPreenchidaId == null) {
        throw Exception('APR preenchida ainda não criada');
      }

      AppLogger.d(
          '🖋️ [AprController] Salvando assinatura para técnico $tecnicoId');

      final assinatura = AprAssinaturaTableCompanion(
        aprPreenchidaId: d.Value(aprPreenchidaId!),
        assinatura: d.Value(assinaturaBytes),
        dataAssinatura: d.Value(DateTime.now()),
        usuarioId: d.Value(Get.find<SessionManager>().usuario!.id),
        tecnicoId: d.Value(tecnicoId),
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

  Future<void> carregarAssinaturas() async {
    if (aprPreenchidaId == null) return;

    try {
      AppLogger.d(
          '📥 [AprController] Buscando assinaturas da APR $aprPreenchidaId');
      final assinaturasData =
          await aprService.buscarAssinaturas(aprPreenchidaId!);
      assinaturas.assignAll(
        assinaturasData.map((a) => AssinaturaModel(
              assinatura: a.assinatura,
              tecnicoId: a.tecnicoId,
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

  Future<void> criarAprPreenchida() async {
    if (atividadeId == null || aprSelecionada == null) return;

    try {
      AppLogger.d('📄 [AprController] Criando APR preenchida...');
      aprPreenchidaId = await aprService.criarAprPreenchida(
        atividadeId!,
        aprSelecionada!.id,
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
