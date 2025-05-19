import 'package:sympla_app/core/domain/dto/anomalia/anomalia_table_dto.dart';

abstract class AnomaliaRepository {
  Future<List<AnomaliaTableDto>> buscarAnomaliasPorAtividade(
      String atividadeId);
  Future<void> salvarAnomalias(List<AnomaliaTableDto> anomalias);

  deleteById(int id) {}

  Future<void> salvarAnomalia(AnomaliaTableDto anomalia);

  Future<void> deletarAnomalias(List<AnomaliaTableDto> anomalias);
}
