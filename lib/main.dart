import 'package:cardapio/app/core/hive/hive_init.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInit.init();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.SPLASH,
      getPages: AppPages.routes,
    ),
  );
}
