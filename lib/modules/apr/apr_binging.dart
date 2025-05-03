import 'package:get/get.dart';
import 'package:sympla_app/core/data/repositories/apr/apr_preenchida_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/tecnicos_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/apr/apr_preenchida_repository.dart';
import 'package:sympla_app/core/domain/repositories/tecnicos_repository.dart';
import 'package:sympla_app/core/services/apr_service.dart';
import 'package:sympla_app/core/data/repositories/apr/apr_assinatura_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/apr/apr_assinatura_repository.dart';
import 'package:sympla_app/core/domain/repositories/apr/apr_repository.dart';
import 'package:sympla_app/core/domain/repositories/apr/apr_perguntas_repository.dart';
import 'package:sympla_app/core/domain/repositories/apr/apr_respostas_repository.dart';
import 'package:sympla_app/core/domain/repositories/atividade/atividade_repository.dart';
import 'package:sympla_app/core/data/repositories/apr/apr_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/apr/apr_perguntas_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/apr/apr_respostas_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/atividade/atividade_repository_impl.dart';
import 'package:sympla_app/core/services/sync/atividade_sync_service.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
import 'package:sympla_app/modules/apr/apr_controller.dart';

class AprBinding extends Bindings {
  @override
  void dependencies() {
    // Repositórios
    Get.lazyPut<AtividadeRepository>(() => AtividadeRepositoryImpl(
          dio: Get.find(),
          db: Get.find(),
        ));

    Get.lazyPut<AprRepository>(
        () => AprRepositoryImpl(dio: Get.find(), db: Get.find()));

    Get.lazyPut<AprPerguntasRepository>(
        () => AprPerguntasRepositoryImpl(dio: Get.find(), db: Get.find()));

    Get.lazyPut<AprRespostasRepository>(
        () => AprRespostasRepositoryImpl(db: Get.find()));

    Get.lazyPut<AprAssinaturaRepository>(
        () => AprAssinaturaRepositoryImpl(Get.find()));

    Get.lazyPut<TecnicosRepository>(() => TecnicosRepositoryImpl(
          dio: Get.find(),
          db: Get.find(),
        ));

    Get.lazyPut<AprPreenchidaRepository>(
        () => AprPreenchidaRepositoryImpl(db: Get.find()));

    Get.lazyPut<AprAssinaturaRepository>(
        () => AprAssinaturaRepositoryImpl(Get.find()));

    // Services
    Get.lazyPut(() => AprService(
          aprRepository: Get.find(),
          aprPerguntasRepository: Get.find(),
          aprRespostasRepository: Get.find(),
          tecnicosRepository: Get.find(),
          aprPreenchidaRepository: Get.find(),
          aprAssinaturaRepository: Get.find(),
        ));

    Get.lazyPut(() => AtividadeController(
        atividadeSyncService: Get.find<AtividadeSyncService>()));

    // Controller
    Get.lazyPut<AprController>(() => AprController(
          aprService: Get.find(),
          atividadeController: Get.find(),
        ));
  }
}
