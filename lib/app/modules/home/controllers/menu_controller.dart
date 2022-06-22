import 'package:get/get.dart';

import 'package:cardapio/app/data/model/menu.dart';
import 'package:cardapio/app/data/service/menu_service.dart';

class MenuController extends GetxController {
  final _selectedMenu = 0.obs;
  int get selectedMenu => _selectedMenu.value;
  set selectedMenu(int index) => _selectedMenu(index);

  final _menu = <Menu>[].obs;
  List<Menu>? get menu => _menu;
  set menu(List<Menu>? menu) {
    _menu.clear();
    _menu.addAll(menu!);
  }

  final MenuService service;
  MenuController({
    required this.service,
  });

  @override
  void onInit() {
    super.onInit();
    buildMenu();
  }

  Future<void> buildMenu() async {
    _menu(await service.buildMenu());
  }
}
