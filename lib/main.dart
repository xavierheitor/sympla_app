import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/app.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    AppLogger.e('[FlutterError]',
        tag: 'GlobalError',
        error: details.exception,
        stackTrace: details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.e('[PlatformError]',
        tag: 'GlobalError', error: error, stackTrace: stack);
    return true;
  };

  Get.config(
    enableLog: true,
    logWriterCallback: (text, {bool isError = false}) {
      if (isError) {
        AppLogger.e('[GETX] $text', tag: 'GetX');
      } else {
        AppLogger.d('[GETX] $text', tag: 'GetX');
      }
    },
  );
  runApp(const SymplaApp());
}
