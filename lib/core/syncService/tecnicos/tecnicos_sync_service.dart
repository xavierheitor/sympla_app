import 'package:drift/drift.dart';
import 'package:sympla_app/core/domain/repositories/tecnicos_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class TecnicosSyncService {
  final TecnicosRepository repository;

  TecnicosSyncService(this.repository);

  Future<void> sincronizar() async {
    try {
      final tecnicos = await repository.buscarTodos();
      final tecnicosCompanion = tecnicos
          .map((t) => TecnicosTableCompanion(
                id: Value(t.id),
                nome: Value(t.nome),
                matricula: Value(t.matricula),
                sincronizado: const Value(true),
              ))
          .toList();
      await repository.sincronizarTecnicos(tecnicosCompanion);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[tecnicos_sync_service - sincronizar] ${erro.mensagem}',
        tag: 'TecnicosSyncService',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }
}
