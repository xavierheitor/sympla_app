import 'package:get/get.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
import 'package:sympla_app/core/domain/repositories/mp_bb/formulario_bateria_repository.dart';
import 'package:sympla_app/core/domain/repositories/mp_bb/medicao_elemento_bateria_repository.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/modules/mp_bb/mp_bb_form_controller.dart';
import 'package:sympla_app/modules/mp_bb/mp_bb_form_service.dart';
import 'package:sympla_app/core/data/repositories/mp_bb/formulario_bateria_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/mp_bb/medicao_elemento_bateria_repository_impl.dart';

class MpBbFormBinding extends Bindings {
  @override
  void dependencies() {
    final db = Get.find<AppDatabase>();
    final atividadeId =
        Get.find<AtividadeController>().atividadeEmAndamento.value?.id ?? 0;

    Get.lazyPut<FormularioBateriaRepository>(
        () => FormularioBateriaRepositoryImpl(db: db));
    Get.lazyPut<MedicaoElementoBateriaRepository>(
        () => MedicaoElementoBateriaRepositoryImpl(db: db));

    Get.lazyPut(() => MpBbFormService(
          formularioRepository: Get.find<FormularioBateriaRepository>(),
          medicaoRepository: Get.find<MedicaoElementoBateriaRepository>(),
        ));

    Get.lazyPut(() => MpBbFormController(
          service: Get.find<MpBbFormService>(),
          atividadeId: atividadeId,
        ));
  }
}
