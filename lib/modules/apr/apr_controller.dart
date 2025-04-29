import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
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

    await carregarApr();
  }

  Future<void> carregarApr() async {
    final atividade = atividadeController.atividadeEmAndamento.value;

    if (atividade == null) {
      AppLogger.w('⚠️ Tentativa de carregar APR sem atividade em andamento',
          tag: 'AprController');
      return;
    }

    atividadeId = atividade.id; // <-- Armazena o ID da atividade normalmente

    try {
      AppLogger.d(
          '🔄 Iniciando carregamento da APR para atividade $atividadeId',
          tag: 'AprController');
      isLoading.value = true;

      // 🔥 O correto: buscar a APR pelo tipo da atividade
      aprSelecionada = await aprService.buscarAprPorTipoAtividade(
        atividade.tipoAtividadeId,
      );
      AppLogger.d(
          '📄 APR encontrada - ID: ${aprSelecionada?.id}, UUID: ${aprSelecionada?.uuid}',
          tag: 'AprController');

      final perguntasCarregadas =
          await aprService.buscarPerguntas(aprSelecionada!.id);
      AppLogger.d(
          '❓ ${perguntasCarregadas.length} perguntas carregadas para APR ${aprSelecionada?.id}',
          tag: 'AprController');
      AppLogger.d(
          '📋 IDs das perguntas: ${perguntasCarregadas.map((p) => p.id).join(', ')}',
          tag: 'AprController');
      perguntas.assignAll(perguntasCarregadas);

      final respostasIniciais = perguntas
          .map((p) => AprRespostaTableCompanion(
                perguntaId: d.Value(p.id),
                resposta: const d.Value(RespostaApr.nao),
                observacao: const d.Value(''),
              ))
          .toList();
      AppLogger.d(
          '📝 ${respostasIniciais.length} respostas iniciais criadas para ${perguntas.length} perguntas',
          tag: 'AprController');
      respostas.assignAll(respostasIniciais);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprController - carregarApr] ${erro.mensagem}',
          tag: 'AprController', error: e, stackTrace: s);
      Get.snackbar('Erro', erro.mensagem,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError);
    } finally {
      isLoading.value = false;
      AppLogger.d(
          '✅ Carregamento da APR finalizado - Total de perguntas: ${perguntas.length}, Total de respostas: ${respostas.length}',
          tag: 'AprController');
    }
  }

  void atualizarResposta(int perguntaId, RespostaApr resposta,
      {String? observacao}) {
    AppLogger.d(
        '🔄 Atualizando resposta para pergunta $perguntaId - Nova resposta: $resposta${observacao != null ? ', Observação: $observacao' : ''}',
        tag: 'AprController');
    final index = respostas.indexWhere((r) => r.perguntaId.value == perguntaId);
    if (index != -1) {
      respostas[index] = respostas[index].copyWith(
        resposta: d.Value(resposta),
        observacao: d.Value(observacao ?? respostas[index].observacao.value),
      );
      AppLogger.d(
          '✅ Resposta atualizada com sucesso - Total de respostas: ${respostas.length}',
          tag: 'AprController');
    } else {
      AppLogger.w(
          '⚠️ Pergunta $perguntaId não encontrada para atualização - Total de respostas: ${respostas.length}',
          tag: 'AprController');
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
      AppLogger.d(
          '💾 Iniciando salvamento das respostas - Total: ${respostas.length}',
          tag: 'AprController');
      isLoading.value = true;

      final sucesso = await aprService.salvarRespostas(respostas.toList());
      if (sucesso) {
        AppLogger.d(
            '✅ Respostas salvas com sucesso! - Total salvo: ${respostas.length}',
            tag: 'AprController');
        Get.back();
      } else {
        AppLogger.w(
            '⚠️ Falha ao salvar respostas - Total tentado: ${respostas.length}',
            tag: 'AprController');
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
      AppLogger.d(
          '🏁 Processo de salvamento finalizado - Total de respostas: ${respostas.length}',
          tag: 'AprController');
    }
  }
}
