import 'package:flutter/foundation.dart';

class AppLogger {
  static void log(String message, {String tag = 'LOG'}) {
    if (kDebugMode) {
      print('[$tag] $message');
    }
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('[ERROR] $message');
      if (error != null) print('Error: $error');
      if (stackTrace != null) print(stackTrace);
    }
  }
}
