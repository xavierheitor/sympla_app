import 'package:flutter/foundation.dart';

enum LogLevel { verbose, debug, info, warning, error }

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

  // Atalhos
  static void v(String message, {String tag = 'APP'}) =>
      log(message, level: LogLevel.verbose, tag: tag);
  static void d(String message, {String tag = 'APP'}) =>
      log(message, level: LogLevel.debug, tag: tag);
  static void i(String message, {String tag = 'APP'}) =>
      log(message, level: LogLevel.info, tag: tag);
  static void w(String message, {String tag = 'APP'}) =>
      log(message, level: LogLevel.warning, tag: tag);
  static void e(String message,
          {String tag = 'APP', dynamic error, StackTrace? stackTrace}) =>
      log(message,
          level: LogLevel.error,
          tag: tag,
          error: error,
          stackTrace: stackTrace);
}
