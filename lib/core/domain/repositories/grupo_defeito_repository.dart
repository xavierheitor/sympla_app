import 'package:sympla_app/core/storage/app_database.dart';

abstract class GrupoDefeitoRepository {
  Future<List<GrupoDefeitoEquipamentoTableCompanion>> buscarDaApi();
  Future<void> salvarNoBanco(List<GrupoDefeitoEquipamentoTableCompanion> dados);
  Future<bool> estaVazio();
}
