import 'package:sympla_app/core/storage/app_database.dart';

abstract class AprAssinaturaRepository {
  Future<void> salvarAssinatura(AprAssinaturaTableCompanion assinatura);
  Future<List<AprAssinaturaTableData>> buscarAssinaturasPorAprPreenchida(
      int aprPreenchidaId);
  Future<int> contarAssinaturasPorAprPreenchida(int aprPreenchidaId);

  deletarAssinaturasPorAprPreenchida(int aprPreenchidaId) {}
}
