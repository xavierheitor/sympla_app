import 'package:sympla_app/core/domain/dto/mpbb/formulario_bateria_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpbb/medicao_elemento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/mpbb_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/repository_helper.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/mpbb_dao.dart';

/// 🔥 Implementação concreta do repositório de banco de baterias (MPBB)
/// Usando RepositoryHelper para logs e tratamento de erros.
class MpbbRepositoryImpl with RepositoryHelper implements MpbbRepository {
  final AppDatabase db;
  final MpbbDao mpbbDao;
  final DioClient dio;

  MpbbRepositoryImpl(this.db, this.dio) : mpbbDao = db.mpbbDao;

  // ---------------------------------------------------------------------------
  // 🗂️ FORMULÁRIO MPBB
  // ---------------------------------------------------------------------------

  /// 🔍 Busca o formulário vinculado à atividade (pode ser nulo se não existir).
  @override
  Future<FormularioBateriaTableDto?> buscarFormulario(String atividadeId) {
    return executar('buscarFormulario', () async {
      final lista = await mpbbDao.buscarFormularioPorAtividade(atividadeId);
      if (lista.isEmpty) {
        AppLogger.w(
            '[MpbbRepository] Nenhum formulário encontrado para atividade $atividadeId');
        return null;
      }
      return FormularioBateriaTableDto.fromData(lista.first);
    }, onErrorReturn: null);
  }

  /// 💾 Salva (insere ou atualiza) um formulário.
  @override
  Future<void> salvarFormulario(FormularioBateriaTableDto formulario) {
    return executar('salvarFormulario', () async {
      await mpbbDao.salvarFormulario(formulario.toCompanion());
    });
  }

  /// 🗑️ Deleta todos os formulários vinculados à atividade.
  @override
  Future<void> deleteByAtividadeId(String atividadeId) {
    return executar('deleteByAtividadeId', () {
      return mpbbDao.deletarFormularioPorAtividade(atividadeId);
    });
  }

  /// 🔍 Busca todos os formulários vinculados a uma atividade (normalmente só existe 1).
  @override
  Future<List<FormularioBateriaTableDto>> getByAtividadeId(String atividadeId) {
    return executar('getByAtividadeId', () async {
      final lista = await mpbbDao.buscarFormularioPorAtividade(atividadeId);
      return lista.map(FormularioBateriaTableDto.fromData).toList();
    }, onErrorReturn: []);
  }

  /// 💾 Insere (upsert) um formulário diretamente a partir do Companion.
  @override
  Future<void> insert(FormularioBateriaTableDto formulario) {
    return executar('insertFormulario', () {
      return mpbbDao.salvarFormulario(formulario.toCompanion());
    });
  }

  Future<int> salvarFormularioRetornandoId(
      FormularioBateriaTableDto formulario) {
    return executar('salvarFormularioRetornandoId', () async {
      return await mpbbDao
          .salvarFormularioRetornandoId(formulario.toCompanion());
    });
  }

  // ---------------------------------------------------------------------------
  // 🔢 MEDIÇÕES DOS ELEMENTOS
  // ---------------------------------------------------------------------------

  /// 🔍 Busca todas as medições vinculadas a um formulário.
  @override
  Future<List<MedicaoElementoMpbbTableDto>> getByFormularioId(
      int formularioId) {
    return executar('getByFormularioId', () async {
      final lista = await mpbbDao.buscarMedicoesPorFormulario(formularioId);
      return lista.map(MedicaoElementoMpbbTableDto.fromData).toList();
    }, onErrorReturn: []);
  }

  /// 💾 Insere todas as medições (em batch).
  @override
  Future<void> insertAll(List<MedicaoElementoMpbbTableDto> medicoes) {
    return executar('insertAllMedicoes', () async {
      await mpbbDao
          .salvarMedicoes(medicoes.map((e) => e.toCompanion()).toList());
    });
  }
}
