import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/domain/dto/mpbb/formulario_bateria_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpbb/medicao_elemento_table_dto.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/modules/mp_bb/mp_bb_form_service.dart';

/// 📦 Controller do formulário de bateria
///
/// Responsabilidades:
/// - Carrega o formulário de bateria
/// - Gerencia o estado do formulário
/// - Salva o formulário de bateria
/// - Valida os dados do formulário
class MpBbFormController extends GetxController {
  final MpBbFormService service;
  final AtividadeController atividadeController;

  var carregando = false.obs;
  var formulario = Rxn<FormularioBateriaTableDto>();
  var medicoes = <MedicaoElementoMpbbTableDto>[].obs;

  MpBbFormController({
    required this.service,
  }) : atividadeController = Get.find();

  @override
  void onInit() {
    super.onInit();
    carregarFormulario();

  }

  Future<void> carregarFormulario() async {
    try {
      carregando.value = true;
      AppLogger.d(
          '[MpBbFormController] Carregando formulário da atividade ${atividadeController.atividadeEmAndamento.value!.uuid}');

      final form = await service.buscarPorAtividade(
          atividadeController.atividadeEmAndamento.value!.uuid);
      final lista = form != null
          ? await service.buscarMedicoes(form.id!)
          : <MedicaoElementoMpbbTableDto>[];

      formulario.value = form;
      medicoes.value = lista;

      AppLogger.d(
          '[MpBbFormController] Formulário: ${form != null}, Medições: ${lista.length}');

      if (form != null && lista.isNotEmpty) {
        AppLogger.d(
            '[MpBbFormController] Formulário já preenchido. Sinalizando conclusão da etapa MPBB');
        final atividadeController = Get.find<AtividadeController>();
        await atividadeController.avancar();
      }
    } catch (e, s) {
      AppLogger.e('[MpBbFormController] Erro ao carregar formulário',
          error: e, stackTrace: s);
    } finally {
      carregando.value = false;
    }
  }

  Future<void> salvarFormulario({
    required FormularioBateriaTableDto dados,
    required List<MedicaoElementoMpbbTableDto> medicoesList,
  }) async {
    try {
      carregando.value = true;
      await service.salvarFormulario(dados, medicoesList);
      await carregarFormulario();
      AppLogger.d('[MpBbFormController] Formulário salvo com sucesso');

      final atividadeController = Get.find<AtividadeController>();
      await atividadeController.avancar();
    } catch (e, s) {
      AppLogger.e('[MpBbFormController] Erro ao salvar formulário',
          error: e, stackTrace: s);
    } finally {
      carregando.value = false;
    }
  }
}
