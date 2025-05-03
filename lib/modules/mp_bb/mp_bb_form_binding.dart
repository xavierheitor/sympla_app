import 'package:get/get.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/modules/mp_bb/mp_bb_form_controller.dart';
import 'package:sympla_app/modules/mp_bb/mp_bb_form_service.dart';
import 'package:sympla_app/core/data/repositories/mp_bb/formulario_bateria_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/mp_bb/medicao_elemento_bateria_repository_impl.dart';

class MpBbFormBinding extends Bindings {
  final int atividadeId;

  MpBbFormBinding({required this.atividadeId});

  @override
  void dependencies() {
    final db = Get.find<AppDatabase>();

    Get.lazyPut(() => FormularioBateriaRepositoryImpl(db: db));
    Get.lazyPut(() => MedicaoElementoBateriaRepositoryImpl(db: db));

    Get.lazyPut(() => MpBbFormService(
          formularioRepository: Get.find(),
          medicaoRepository: Get.find(),
        ));

    Get.lazyPut(() => MpBbFormController(
          service: Get.find(),
          atividadeId: atividadeId,
        ));
  }
}
