import 'package:sympla_app/core/storage/app_database.dart';

abstract class AprAssinaturasRepository {
  Future<void> adicionarAssinatura(AprAssinaturaTableCompanion assinatura);
  Future<List<AprAssinaturaTableData>> buscarAssinaturas(int aprPreenchidaId);
  Future<bool> temDuasAssinaturas(int aprPreenchidaId);
}
