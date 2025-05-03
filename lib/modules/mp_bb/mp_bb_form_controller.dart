import 'package:get/get.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/modules/mp_bb/mp_bb_form_service.dart';

class MpBbFormController extends GetxController {
  final MpBbFormService service;
  final int atividadeId;

  var carregando = false.obs;
  var formulario = Rxn<FormularioBateriaTableData>();
  var medicoes = <MedicaoElementoBateriaTableData>[].obs;

  MpBbFormController({
    required this.service,
    required this.atividadeId,
  });

  @override
  void onInit() {
    super.onInit();
    carregarFormulario();
  }

  Future<void> carregarFormulario() async {
    try {
      carregando.value = true;
      AppLogger.d(
          '[MpBbFormController] Carregando formulário da atividade $atividadeId');

      final form = await service.buscarPorAtividade(atividadeId);
      final lista = form != null
          ? await service.buscarMedicoes(form.id)
          : <MedicaoElementoBateriaTableData>[];

      formulario.value = form;
      medicoes.value = lista;

      AppLogger.d(
          '[MpBbFormController] Formulário: ${form != null}, Medições: ${lista.length}');
    } catch (e, s) {
      AppLogger.e('[MpBbFormController] Erro ao carregar formulário',
          error: e, stackTrace: s);
    } finally {
      carregando.value = false;
    }
  }

  Future<void> salvarFormulario({
    required FormularioBateriaTableCompanion dados,
    required List<MedicaoElementoBateriaTableCompanion> medicoesList,
  }) async {
    try {
      carregando.value = true;
      await service.salvarFormulario(dados, medicoesList);
      await carregarFormulario();
    } catch (e, s) {
      AppLogger.e('[MpBbFormController] Erro ao salvar formulário',
          error: e, stackTrace: s);
    } finally {
      carregando.value = false;
    }
  }
}
