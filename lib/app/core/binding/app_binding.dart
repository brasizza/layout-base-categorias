import 'package:cardapio/app/core/hive/hive_init.dart';
import 'package:get/instance_manager.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(await HiveInit.init());
  }
}
