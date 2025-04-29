import 'package:get/get.dart';
import 'package:sympla_app/core/data/repositories/apr_preenchida_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/tecnicos_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/apr_preenchida_repository.dart';
import 'package:sympla_app/core/domain/repositories/tecnicos_repository.dart';
import 'package:sympla_app/core/services/apr_assinatura_service.dart';
import 'package:sympla_app/core/services/apr_service.dart';
import 'package:sympla_app/core/data/repositories/apr_assinatura_repository_impl.dart';
import 'package:sympla_app/core/domain/repositories/apr_assinatura_repository.dart';
import 'package:sympla_app/core/domain/repositories/apr_repository.dart';
import 'package:sympla_app/core/domain/repositories/apr_perguntas_repository.dart';
import 'package:sympla_app/core/domain/repositories/apr_respostas_repository.dart';
import 'package:sympla_app/core/domain/repositories/atividade_repository.dart';
import 'package:sympla_app/core/data/repositories/apr_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/apr_perguntas_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/apr_respostas_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/atividade_repository_impl.dart';
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
    Get.lazyPut<AprPreenchidaRepository>(() => AprPreenchidaRepositoryImpl(
          db: Get.find(),
        ));
    // Services
    Get.lazyPut(() => AprService(
          aprRepository: Get.find<AprRepository>(),
          aprPerguntasRepository: Get.find<AprPerguntasRepository>(),
          aprRespostasRepository: Get.find<AprRespostasRepository>(),
          tecnicosRepository: Get.find<TecnicosRepository>(),
          aprAssinaturaService: Get.find<AprAssinaturaService>(),
          aprPreenchidaRepository: Get.find<AprPreenchidaRepository>(),
        ));

    Get.lazyPut(
        () => AprAssinaturaService(aprAssinaturaRepository: Get.find()));

    // Controller
    Get.lazyPut<AprController>(() => AprController(
          aprService: Get.find<AprService>(),
          aprAssinaturaService: Get.find<AprAssinaturaService>(),
        ));
  }
}
