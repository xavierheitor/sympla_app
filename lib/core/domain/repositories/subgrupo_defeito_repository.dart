import 'package:sympla_app/core/storage/app_database.dart';

abstract class SubgrupoDefeitoRepository {
  Future<List<SubgrupoDefeitoEquipamentoTableCompanion>> buscarDaApi();
  Future<void> salvarNoBanco(
      List<SubgrupoDefeitoEquipamentoTableCompanion> dados);
  Future<bool> estaVazio();
}
