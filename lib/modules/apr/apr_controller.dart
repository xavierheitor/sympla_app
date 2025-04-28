import 'dart:typed_data';

import 'package:get/get.dart';
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

  AprController({
    required this.aprService,
    required this.aprAssinaturaService,
  });

  final RxBool isLoading = false.obs;
  final RxList<AprQuestionTableData> perguntas = <AprQuestionTableData>[].obs;
  final RxList<AprRespostaTableCompanion> respostas =
      <AprRespostaTableCompanion>[].obs;
  final RxList<AssinaturaModel> assinaturas = <AssinaturaModel>[].obs;
  final RxInt quantidadeAssinaturas = 0.obs;

  AprTableData? aprSelecionada;
  int? atividadeId;
  int? aprPreenchidaId;

  @override
  Future<void> onInit() async {
    super.onInit();
    AppLogger.d('🎯 AprController iniciado', tag: 'AprController');

    final arguments = Get.arguments;
    if (arguments != null && arguments is int) {
      atividadeId = arguments;
      await carregarApr();
    }
  }

  Future<void> carregarApr() async {
    if (atividadeId == null) return;

    try {
      isLoading.value = true;

      aprSelecionada = await aprService.buscarAprPorTipoAtividade(atividadeId!);
      perguntas.assignAll(await aprService.buscarPerguntas(aprSelecionada!.id));

      respostas.assignAll(
        perguntas.map((p) => AprRespostaTableCompanion(
              perguntaId: d.Value(p.id),
              resposta: const d.Value(RespostaApr.nao),
              observacao: const d.Value(''),
            )),
      );
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

  void atualizarResposta(int perguntaId, RespostaApr resposta,
      {String? observacao}) {
    final index = respostas.indexWhere((r) => r.perguntaId.value == perguntaId);
    if (index != -1) {
      respostas[index] = respostas[index].copyWith(
        resposta: d.Value(resposta),
        observacao: d.Value(observacao ?? respostas[index].observacao.value),
      );
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
        usuarioId: const d.Value(1), // TODO: substituir para usuário logado
        tecnicoId:
            const d.Value(1), // TODO: substituir para técnico selecionado
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

  Future<void> salvarRespostas() async {
    try {
      isLoading.value = true;

      final sucesso = await aprService.salvarRespostas(respostas.toList());
      if (sucesso) {
        AppLogger.d('✅ Respostas salvas com sucesso!', tag: 'AprController');
        Get.back(); // Voltar após salvar se quiser
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
}
