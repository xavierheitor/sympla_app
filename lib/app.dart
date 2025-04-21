import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/routes/app_pages.dart';

class SymplaApp extends StatelessWidget {
  const SymplaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sympla App',
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
