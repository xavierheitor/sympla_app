// === apr_controller.dart ===

import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
import 'package:sympla_app/core/data/models/resposta_formulario.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/services/apr_assinatura_service.dart';
import 'package:sympla_app/core/services/apr_service.dart';
import 'package:sympla_app/core/session/session_manager.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:drift/drift.dart' as d;
import 'package:sympla_app/core/storage/converters/resposta_apr_converter.dart';
import 'package:sympla_app/core/data/models/assinatura_model.dart';

class AprController extends GetxController {
  final AprService aprService;
  final AprAssinaturaService aprAssinaturaService;
  final AtividadeController atividadeController;

  AprController({
    required this.aprService,
    required this.aprAssinaturaService,
  }) : atividadeController = Get.find<AtividadeController>();

  final RxBool isLoading = false.obs;
  final RxList<AprQuestionTableData> perguntas = <AprQuestionTableData>[].obs;
  final RxList<RespostaFormulario> respostasFormulario =
      <RespostaFormulario>[].obs;
  final RxList<AssinaturaModel> assinaturas = <AssinaturaModel>[].obs;
  // final RxInt quantidadeAssinaturas = 0.obs;

  final RxList<TecnicosTableData> tecnicos = <TecnicosTableData>[].obs;

  AprTableData? aprSelecionada;
  int? atividadeId;
  int? aprPreenchidaId;

  bool salvouFormulario = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    AppLogger.d('🎯 AprController iniciado', tag: 'AprController');

    final atividade = atividadeController.atividadeEmAndamento.value;

    if (atividade == null) {
      AppLogger.w('⚠️ Sem atividade em andamento, não é possível carregar APR',
          tag: 'AprController');
      return;
    }

    atividadeId = atividade.id;

    try {
      isLoading.value = true;

      // ✅ Verificar se já foi preenchida
      final aprPreenchidaExiste =
          await aprService.aprJaPreenchida(atividadeId!);

      if (aprPreenchidaExiste) {
        AppLogger.d(
            '✅ APR já preenchida para atividade $atividadeId, redirecionando para checklist...',
            tag: 'AprController');
        Get.offAllNamed('/checklist');
        return;
      }

      // Continua fluxo normal se não foi preenchida
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
    super.onClose();
    apagarAprPreenchidaSeNaoSalvou();
  }

  Future<void> carregarApr() async {
    final atividade = atividadeController.atividadeEmAndamento.value;

    if (atividade == null) {
      AppLogger.w('⚠️ Tentativa de carregar APR sem atividade em andamento',
          tag: 'AprController');
      return;
    }

    atividadeId = atividade.id;

    try {
      AppLogger.d(
          '🔄 Iniciando carregamento da APR para atividade \$atividadeId',
          tag: 'AprController');
      isLoading.value = true;

      aprSelecionada =
          await aprService.buscarAprPorTipoAtividade(atividade.tipoAtividadeId);
      final perguntasCarregadas =
          await aprService.buscarPerguntas(aprSelecionada!.id);
      perguntas.assignAll(perguntasCarregadas);

      final respostasIniciais =
          perguntas.map((p) => RespostaFormulario(perguntaId: p.id)).toList();
      respostasFormulario.assignAll(respostasIniciais);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprController - carregarApr] \${erro.mensagem}',
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
      respostasFormulario[index] = RespostaFormulario(
        perguntaId: perguntaId,
        resposta: resposta,
        observacao: observacao ?? respostasFormulario[index].observacao,
      );
    }
  }

  Future<void> salvarRespostas() async {
    try {
      AppLogger.d('💾 Iniciando salvamento das respostas',
          tag: 'AprController');
      isLoading.value = true;

      final respostasParaSalvar = respostasFormulario.map((r) {
        if (r.resposta == null) {
          throw Exception('Existem perguntas sem resposta selecionada!');
        }

        return AprRespostaTableCompanion(
          perguntaId: d.Value(r.perguntaId),
          resposta: d.Value(r.resposta!),
          aprPreenchidaId: d.Value(aprPreenchidaId!),
          observacao: d.Value(r.observacao),
        );
      }).toList();

      final sucesso = await aprService.salvarRespostas(respostasParaSalvar);

      if (sucesso && aprPreenchidaId != null) {
        await aprService.atualizarDataPreenchimentoAprPreenchida(
          aprPreenchidaId!,
          DateTime.now(),
        );
        salvouFormulario = true;
        Get.back();
      }
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprController - salvarRespostas] \${erro.mensagem}',
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
        throw Exception('APR preenchida ainda não foi criada');
      }

      final assinatura = AprAssinaturaTableCompanion(
        aprPreenchidaId: d.Value(aprPreenchidaId!),
        assinatura: d.Value(assinaturaBytes),
        dataAssinatura: d.Value(DateTime.now()),
        usuarioId: d.Value(Get.find<SessionManager>().usuario!.id),
        tecnicoId: d.Value(tecnicoId),
      );

      await aprAssinaturaService.salvarAssinatura(assinatura);
      await carregarAssinaturas();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprController - adicionarAssinatura] \${erro.mensagem}',
          tag: 'AprController', error: e, stackTrace: s);
      Get.snackbar('Erro', erro.mensagem,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError);
    }
  }

  Future<void> carregarAssinaturas() async {
    if (aprPreenchidaId == null) return;

    try {
      final assinaturasData =
          await aprAssinaturaService.buscarAssinaturas(aprPreenchidaId!);
      assinaturas.assignAll(
        assinaturasData.map((a) => AssinaturaModel(
              assinatura: a.assinatura,
              tecnicoId: a.tecnicoId,
            )),
      );
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprController - carregarAssinaturas] \${erro.mensagem}',
          tag: 'AprController', error: erro.mensagem, stackTrace: erro.stack);
    }
  }

  Future<void> carregarTecnicos() async {
    try {
      final tecnicosData = await aprService.buscarTecnicos();
      tecnicos.assignAll(tecnicosData);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprController - carregarTecnicos] \${erro.mensagem}',
          tag: 'AprController', error: erro.mensagem, stackTrace: erro.stack);
    }
  }

  Future<void> criarAprPreenchida() async {
    if (atividadeId == null || aprSelecionada == null) return;

    try {
      aprPreenchidaId = await aprService.criarAprPreenchida(
        atividadeId!,
        aprSelecionada!.id, // ✅ agora passa também o aprId
      );
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
        await aprService.deletarAprPreenchida(aprPreenchidaId!);
        AppLogger.d('🗑️ APR Preenchida apagada por abandono',
            tag: 'AprController');
      }
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AprController - apagarAprPreenchidaSeNaoSalvou] \${erro.mensagem}',
          tag: 'AprController',
          error: erro.mensagem,
          stackTrace: erro.stack);
    }
  }

  bool podeSalvar() {
    final respostasPreenchidas =
        respostasFormulario.where((r) => r.resposta != null).length;
    final quantidadeAssinatura = assinaturas.length;

    return respostasPreenchidas == perguntas.length &&
        quantidadeAssinatura >= 2;
  }
}
