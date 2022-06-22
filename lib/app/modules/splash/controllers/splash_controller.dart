import 'package:cardapio/app/core/hive/hive_init.dart';
import 'package:cardapio/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();
    await HiveInit.initCache();
    Get.toNamed(Routes.HOME);
  }
}
