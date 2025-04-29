import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
import 'package:sympla_app/core/data/models/resposta_formulario.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/services/apr_assinatura_service.dart';
import 'package:sympla_app/core/services/apr_service.dart';
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
  final RxInt quantidadeAssinaturas = 0.obs;

  AprTableData? aprSelecionada;
  int? atividadeId;
  int? aprPreenchidaId;

  @override
  Future<void> onInit() async {
    super.onInit();
    AppLogger.d('🎯 AprController iniciado', tag: 'AprController');
    await carregarApr();
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
          '🔄 Iniciando carregamento da APR para atividade $atividadeId',
          tag: 'AprController');
      isLoading.value = true;

      aprSelecionada = await aprService.buscarAprPorTipoAtividade(
        atividade.tipoAtividadeId,
      );

      final perguntasCarregadas =
          await aprService.buscarPerguntas(aprSelecionada!.id);

      perguntas.assignAll(perguntasCarregadas);

      final respostasIniciais = perguntas
          .map((p) => RespostaFormulario(
                perguntaId: p.id,
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
          observacao: d.Value(r.observacao),
        );
      }).toList();

      final sucesso = await aprService.salvarRespostas(respostasParaSalvar);

      if (sucesso) {
        Get.back();
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

  Future<void> adicionarAssinatura(Uint8List assinaturaBytes) async {
    try {
      if (aprPreenchidaId == null) {
        throw Exception('APR preenchida ainda não foi criada');
      }

      final assinatura = AprAssinaturaTableCompanion(
        aprPreenchidaId: d.Value(aprPreenchidaId!),
        assinatura: d.Value(assinaturaBytes),
        dataAssinatura: d.Value(DateTime.now()),
        usuarioId: const d.Value(1), // TODO: usuário logado
        tecnicoId: const d.Value(1), // TODO: técnico selecionado
      );

      await aprAssinaturaService.salvarAssinatura(assinatura);
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
      final assinaturasData =
          await aprAssinaturaService.buscarAssinaturas(aprPreenchidaId!);
      assinaturas.assignAll(
        assinaturasData.map((a) => AssinaturaModel(
              assinatura: a.assinatura,
            )),
      );
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprController - carregarAssinaturas] ${erro.mensagem}',
          tag: 'AprController', error: e, stackTrace: s);
    }
  }
}
