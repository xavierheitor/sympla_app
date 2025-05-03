import 'package:get/get.dart';
import 'package:sympla_app/core/controllers/atividade_controller.dart';
import 'package:sympla_app/core/domain/repositories/mp_dj/medicao_pressao_sf6_repository.dart';
import 'package:sympla_app/core/domain/repositories/mp_dj/medicao_resistencia_contato_repository.dart';
import 'package:sympla_app/core/domain/repositories/mp_dj/medicao_resistencia_isolamento_repository.dart';
import 'package:sympla_app/core/domain/repositories/mp_dj/medicao_tempo_operacao_repository.dart';
import 'package:sympla_app/core/domain/repositories/mp_dj/prev_disj_form_repository.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_controller.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_service.dart';

import 'package:sympla_app/core/data/repositories/mp_dj/prev_disj_form_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/mp_dj/medicao_resistencia_contato_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/mp_dj/medicao_resistencia_isolamento_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/mp_dj/medicao_tempo_operacao_repository_impl.dart';
import 'package:sympla_app/core/data/repositories/mp_dj/medicao_pressao_sf6_repository_impl.dart';

class MpDjFormBinding extends Bindings {
  @override
  void dependencies() {
    final db = Get.find<AppDatabase>();
    final atividadeId =
        Get.find<AtividadeController>().atividadeEmAndamento.value?.id ?? 0;

    // Repositórios
    // Repositórios (registrando como as interfaces)
    Get.lazyPut<PrevDisjFormRepository>(
        () => PrevDisjFormRepositoryImpl(db: db));
    Get.lazyPut<MedicaoResistenciaContatoRepository>(
        () => MedicaoResistenciaContatoRepositoryImpl(db: db));
    Get.lazyPut<MedicaoResistenciaIsolamentoRepository>(
        () => MedicaoResistenciaIsolamentoRepositoryImpl(db: db));
    Get.lazyPut<MedicaoTempoOperacaoRepository>(
        () => MedicaoTempoOperacaoRepositoryImpl(db: db));
    Get.lazyPut<MedicaoPressaoSf6Repository>(
        () => MedicaoPressaoSf6RepositoryImpl(db: db));

    // Serviço
    Get.lazyPut(() => MpDjFormService(
          formRepository: Get.find(),
          resistenciaContatoRepository: Get.find(),
          resistenciaIsolamentoRepository: Get.find(),
          tempoOperacaoRepository: Get.find(),
          pressaoSf6Repository: Get.find(),
        ));

    // Controller
    Get.lazyPut(() => MpDjFormController(
          service: Get.find(),
          atividadeId: atividadeId,
        ));
  }
}
