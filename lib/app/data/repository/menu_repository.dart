import 'package:cardapio/app/core/constants.dart';
import 'package:cardapio/app/data/model/menu.dart';
import 'package:get/instance_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MenuRepository {
  Future<List<Menu>?> buildMenu() async {
    Box<Menu> menu = Get.find(tag: Constants.menuHive);
    return menu.values.toList();
  }
}
