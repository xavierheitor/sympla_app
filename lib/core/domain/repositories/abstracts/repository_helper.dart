// lib/core/domain/repositories/repository_helper.dart

import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

mixin RepositoryHelper {
  /// 🔧 Executa uma operação com tratamento de erro e log.
  ///
  /// - [metodo]: nome do método para log.
  /// - [callback]: função assíncrona que executa a operação.
  /// - [onErrorReturn]: valor a ser retornado em caso de erro.
  ///
  /// Exemplo de uso:
  /// ```dart
  /// return executar('buscar', () => dao.buscar());
  /// ```
  Future<T> executar<T>(
    String metodo,
    Future<T> Function() callback, {
    T? onErrorReturn,
  }) async {
    try {
      return await callback();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[Repository - $metodo] ${erro.mensagem}',
        error: e,
        stackTrace: s,
      );
      return onErrorReturn as T;
    }
  }
}
