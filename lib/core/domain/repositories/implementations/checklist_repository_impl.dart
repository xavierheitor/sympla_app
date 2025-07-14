import 'package:sympla_app/core/domain/dto/checklist/checklist_pergunta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_preenchido_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_resposta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/checklist_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/repository_helper.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/checklist_dao.dart';

/// 🔥 Implementação concreta do ChecklistRepository
class ChecklistRepositoryImpl
    with RepositoryHelper
    implements ChecklistRepository {
  final AppDatabase db;
  final ChecklistDao checklistDao;
  final DioClient dio;

  ChecklistRepositoryImpl(this.db, this.dio) : checklistDao = db.checklistDao;

  // --------------------- Modelo ---------------------

  @override
  Future<ChecklistTableDto?> buscarModeloPorTipoAtividade(
      String idTipoAtividade) {
    return executar('buscarModeloPorTipoAtividade', () async {
      final checklist =
          await checklistDao.buscarPorTipoAtividade(idTipoAtividade);
      // ignore: unnecessary_null_comparison
      return checklist != null ? ChecklistTableDto.fromData(checklist) : null;
    }, onErrorReturn: null);
  }

  @override
  Future<bool> checklistEstaVazio() {
    return executar(
        'checklistEstaVazio', () => checklistDao.estaVazioChecklist(),
        onErrorReturn: false);
  }

  // --------------------- Perguntas ---------------------

  @override
  Future<List<ChecklistPerguntaTableDto>> buscarPerguntasRelacionadas(
      String checklistId) {
    return executar('buscarPerguntasRelacionadas', () async {
      final perguntas =
          await checklistDao.buscarPerguntasPorChecklist(checklistId);
      return perguntas.map(ChecklistPerguntaTableDto.fromData).toList();
    }, onErrorReturn: []);
  }

  // --------------------- Checklist Preenchido ---------------------

  @override
  Future<int> criarChecklistPreenchido(ChecklistPreenchidoTableDto checklist) {
    return executar('criarChecklistPreenchido', () async {
      return await checklistDao.criarChecklistPreenchido(checklist);
    }, onErrorReturn: 0);
  }

  @override
  Future<void> atualizarDataPreenchimento(
      int checklistPreenchidoId, DateTime data) {
    return executar('atualizarDataPreenchimento', () {
      return checklistDao.atualizarDataPreenchimento(
          checklistPreenchidoId, data);
    });
  }

  @override
  Future<void> deletarChecklistPreenchido(int checklistPreenchidoId) {
    return executar('deletarChecklistPreenchido', () {
      return checklistDao.deletarChecklistPreenchido(checklistPreenchidoId);
    });
  }

  @override
  Future<bool> existeChecklistPreenchido(String atividadeId) {
    return executar('existeChecklistPreenchido', () async {
      final checklist = await checklistDao.buscarPorAtividade(atividadeId);
      return checklist != null;
    }, onErrorReturn: false);
  }

  @override
  Future<ChecklistPreenchidoTableDto?> buscarChecklistPreenchido(
      String atividadeId) {
    return executar('buscarChecklistPreenchido', () async {
      final checklistPreenchido =
          await checklistDao.buscarPorAtividade(atividadeId);
      return checklistPreenchido != null
          ? ChecklistPreenchidoTableDto.fromData(checklistPreenchido)
          : null;
    }, onErrorReturn: null);
  }

  // --------------------- Respostas ---------------------

  @override
  Future<bool> salvarRespostas(List<ChecklistRespostaTableDto> respostas) {
    return executar('salvarRespostas', () async {
      final companions = respostas.map((e) => e.toCompanion()).toList();
      await checklistDao.salvarRespostas(companions);
      return true;
    }, onErrorReturn: false);
  }

  @override
  Future<List<ChecklistRespostaTableDto>> buscarRespostas(
      int checklistPreenchidoId) {
    return executar('buscarRespostas', () async {
      final respostas = await checklistDao
          .buscarRespostasPorPreenchido(checklistPreenchidoId);
      return respostas.map(ChecklistRespostaTableDto.fromData).toList();
    }, onErrorReturn: []);
  }

@override
Future<void> deletarRespostas(String atividadeId) {
    return executar('deletarRespostas', () async {
      // 🔍 Busca o checklist preenchido pela atividade
      final preenchido = await checklistDao.buscarPorAtividade(atividadeId);

      if (preenchido == null) {
        AppLogger.w(
            '[ChecklistRepositoryImpl] Nenhum checklist preenchido encontrado para atividade $atividadeId. Nada para deletar.');
        return;
    }

      // 🗑️ Deleta as respostas associadas ao preenchimento encontrado
      await checklistDao.deletarRespostasPorPreenchido(preenchido.id);

      AppLogger.d(
          '[ChecklistRepositoryImpl] Respostas do checklist preenchido ${preenchido.id} (atividade $atividadeId) foram deletadas.');
    });
}

  @override
  Future<bool> existeRespostas(int checklistPreenchidoId) {
    return executar('existeRespostas', () async {
      final respostas = await checklistDao
          .buscarRespostasPorPreenchido(checklistPreenchidoId);
      return respostas.isNotEmpty;
    }, onErrorReturn: false);
  }
}
