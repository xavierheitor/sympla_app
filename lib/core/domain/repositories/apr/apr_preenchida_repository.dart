import 'package:sympla_app/core/storage/app_database.dart';

abstract class AprPreenchidaRepository {
  Future<void> criarAprPreenchida(int atividadeId, int aprId, int usuarioId);
  Future<bool> existeAprPreenchida(int atividadeId);
  Future<AprPreenchidaTableData?> buscarAprPreenchida(int atividadeId);
}
