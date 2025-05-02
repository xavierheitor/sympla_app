import 'package:sympla_app/core/storage/app_database.dart';

abstract class EquipamentoRepository {
  Future<List<EquipamentoTableCompanion>> buscarDaApi();
  Future<void> salvarNoBanco(List<EquipamentoTableCompanion> equipamentos);
  Future<bool> estaVazio();
  Future<List<EquipamentoTableData>> buscarPorSubestacao(String subestacao);
}
