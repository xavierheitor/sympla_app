import 'package:sympla_app/core/domain/dto/anomalia/anomalia_table_dto.dart';
import 'package:sympla_app/core/storage/app_database.dart';

abstract class AnomaliaRepository {
  Future<List<AnomaliaTableDto>> buscarAnomaliasPorAtividade(
      String atividadeId);
  Future<void> salvarAnomalias(List<AnomaliaTableDto> anomalias);

  deleteById(int id) {}

  inserir(AnomaliaTableCompanion anomalia) {}

  atualizar(AnomaliaTableCompanion companion) {}
}
