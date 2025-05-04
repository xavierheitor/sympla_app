// HomeBinding
import 'package:get/get.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
import 'package:sympla_app/modules/home/atividade_service.dart';
import 'package:sympla_app/core/syncService/atividade/atividade_sync_service.dart';
import 'package:sympla_app/core/data/repositories/atividade/atividade_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/atividade/atividade_repository.dart';
import 'package:sympla_app/modules/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    //inicia o repositorio das atividades
    Get.lazyPut<AtividadeRepository>(() => AtividadeRepositoryImpl(
          dio: Get.find(),
          db: Get.find(),
        ));

    //inicia o atividad sync e o atividad service
    Get.lazyPut(() => AtividadeSyncService(Get.find()));
    Get.lazyPut(() => AtividadeService(
          atividadeRepository: Get.find(),
        ));

    //inicia o controller de atividade, que a partir dai sera permanente durante a execucao do app
    Get.put<AtividadeController>(
      AtividadeController(
        atividadeService: Get.find(),
        atividadeSyncService: Get.find(),
      ),
      permanent: true,
    );

    //inicia o controller da propria home
    Get.lazyPut(() => HomeController(Get.find(), Get.find()), fenix: true);
  }
}
