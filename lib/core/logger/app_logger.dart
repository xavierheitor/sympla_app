import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// Logger centralizado da aplicação.
///
/// - Em modo debug, imprime mensagens coloridas no console
/// - Persiste logs em arquivo (`app.log`) no diretório de documentos
/// - Funções utilitárias (`i`, `d`, `w`, `e`, `v`) padronizam o uso
enum LogLevel { verbose, debug, info, warning, error }

const _reset = '\x1B[0m';
const _red = '\x1B[31m';
const _yellow = '\x1B[33m';
const _green = '\x1B[32m';
const _blue = '\x1B[34m';
const _magenta = '\x1B[35m';
const _cinza = '\x1B[90m';

class AppLogger {
  static void log(
    String message, {
    LogLevel level = LogLevel.info,
    String tag = 'APP',
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode) return;

    final emoji = {
      LogLevel.verbose: '🔍',
      LogLevel.debug: '🐞',
      LogLevel.info: 'ℹ️',
      LogLevel.warning: '⚠️',
      LogLevel.error: '❌',
    }[level];

    final buffer = StringBuffer();
    buffer.writeln('$emoji [$tag] $message');

    if (error != null) buffer.writeln('   ↳ Error: $error');
    if (stackTrace != null) buffer.writeln('   ↳ Stack: $stackTrace');

    debugPrint(buffer.toString());
  }

  static void i(dynamic msg, {String? tag}) => _log(msg, 'INFO', _green, tag);
  static void d(dynamic msg, {String? tag}) => _log(msg, 'DEBUG', _blue, tag);
  static void w(dynamic msg, {String? tag}) => _log(msg, 'WARN', _yellow, tag);
  static void e(dynamic msg,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(msg, 'ERROR', _red, tag);
    if (error != null) _log(error.toString(), 'ERROR', _red, tag);
    if (stackTrace != null) _log(stackTrace.toString(), 'STACK', _magenta, tag);
  }

  static void v(dynamic msg, {String? tag}) =>
      _log(msg, 'VERBOSE', _cinza, tag);

  static Future<void> _log(dynamic msg, String level, String color,
      [String? tag]) async {
    final now = DateTime.now().toIso8601String();
    final formatted = "[$level] ${tag != null ? '[$tag] ' : ''}$msg";

    // Mostra com cor no terminal
    debugPrint('$color[$now] $formatted$_reset');

    // Salva em arquivo
    await _writeToFile('[$now] $formatted');
  }

  static Future<void> _writeToFile(String content) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/app.log');
      await file.writeAsString('$content\n',
          mode: FileMode.append, flush: true);
    } catch (_) {
      // falha silenciosa
    }
  }
}
