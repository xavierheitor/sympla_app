import 'package:sympla_app/core/domain/dto/anomalia/anomalia_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/anomalia_repository.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/anomalia_dao.dart';

class AnomaliaRepositoryImpl implements AnomaliaRepository {
  final AppDatabase db;
  final AnomaliaDao anomaliaDao;

  AnomaliaRepositoryImpl(this.db) : anomaliaDao = db.anomaliaDao;

  @override
  Future<List<AnomaliaTableDto>> buscarAnomaliasPorAtividade(
      String atividadeId) {
    // TODO: implement buscarAnomaliasPorAtividade
    throw UnimplementedError();
  }

  @override
  Future<void> salvarAnomalias(List<AnomaliaTableDto> anomalias) {
    // TODO: implement salvarAnomalias
    throw UnimplementedError();
  }

  @override
  deleteById(int id) {
    // TODO: implement deleteById
    throw UnimplementedError();
  }

  @override
  atualizar(AnomaliaTableCompanion companion) {
    // TODO: implement atualizar
    throw UnimplementedError();
  }

  @override
  inserir(AnomaliaTableCompanion anomalia) {
    // TODO: implement inserir
    throw UnimplementedError();
  }
}
