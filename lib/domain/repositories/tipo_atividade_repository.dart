import 'package:sympla_app/core/storage/app_database.dart';

abstract class TipoAtividadeRepository {
  Future<List<TipoAtividadeTableCompanion>> buscarDaApi();
  Future<void> salvarNoBanco(List<TipoAtividadeTableCompanion> dados);
}
