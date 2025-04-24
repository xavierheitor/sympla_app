import 'package:drift/backends.dart';
import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

class LoggingExecutor extends QueryExecutor {
  final QueryExecutor _inner;

  LoggingExecutor(this._inner);

  @override
  Future<void> runBatched(BatchedStatements statements) async {
    try {
      AppLogger.v('📦 [Drift] BATCH: $statements');
      return await _inner.runBatched(statements);
    } catch (e, s) {
      AppLogger.e('[DB] Erro em batch',
          tag: 'AppDatabase', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> runCustom(String statement, [List<Object?>? args]) async {
    try {
      AppLogger.v('📦 [Drift] CUSTOM: $statement\nArgs: $args');
      return await _inner.runCustom(statement, args);
    } catch (e, s) {
      AppLogger.e('[DB] Erro em custom SQL',
          tag: 'AppDatabase', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<int> runInsert(String statement, List<Object?> args) async {
    try {
      AppLogger.v('📦 [Drift] INSERT: $statement\nArgs: $args');
      return await _inner.runInsert(statement, args);
    } catch (e, s) {
      AppLogger.e('[DB] Erro em insert',
          tag: 'AppDatabase', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<Map<String, Object?>>> runSelect(
      String statement, List<Object?> args) async {
    try {
      AppLogger.v('📦 [Drift] SELECT: $statement\nArgs: $args');
      return await _inner.runSelect(statement, args);
    } catch (e, s) {
      AppLogger.e('[DB] Erro em select',
          tag: 'AppDatabase', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<int> runUpdate(String statement, List<Object?> args) async {
    try {
      AppLogger.v('📦 [Drift] UPDATE: $statement\nArgs: $args');
      return await _inner.runUpdate(statement, args);
    } catch (e, s) {
      AppLogger.e('[DB] Erro em update',
          tag: 'AppDatabase', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<int> runDelete(String statement, List<Object?> args) async {
    try {
      AppLogger.v('📦 [Drift] DELETE: $statement\nArgs: $args');
      return await _inner.runDelete(statement, args);
    } catch (e, s) {
      AppLogger.e('[DB] Erro em delete',
          tag: 'AppDatabase', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  TransactionExecutor beginTransaction() {
    AppLogger.v('📦 [Drift] BEGIN TRANSACTION');
    return _inner.beginTransaction();
  }

  @override
  QueryExecutor beginExclusive() {
    AppLogger.v('📦 [Drift] BEGIN EXCLUSIVE');
    return _inner.beginExclusive();
  }

  @override
  Future<bool> ensureOpen(QueryExecutorUser user) {
    AppLogger.v('📦 [Drift] ENSURE OPEN');
    return _inner.ensureOpen(user);
  }

  @override
  Future<void> close() => _inner.close();

  @override
  SqlDialect get dialect => _inner.dialect;
}
