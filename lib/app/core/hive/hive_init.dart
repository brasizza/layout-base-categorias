import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:cardapio/app/data/model/menu.dart';
import 'package:cardapio/app/data/repository/cardapio_repository.dart';
import 'package:cardapio/app/data/service/cardapio_service.dart';
import 'package:cardapio/app/modules/home/controllers/cardapio_controller.dart';

import '../../data/model/category.dart';
import '../../data/model/item.dart';
import '../constants.dart';

class HiveInit {
  HiveInit._();

  static HiveInit? _instance;

  static Future<HiveInit> init() async {
    if (_instance == null) {
      await Hive.initFlutter();
      await registerAdapters();
      await openBoxes();
      _instance = HiveInit._();
    }
    return _instance!;
  }

  static Future<void> registerAdapters() async {
    Hive.registerAdapter(ItemAdapter());
    Hive.registerAdapter(CategoryAdapter());
    Hive.registerAdapter(MenuAdapter());
  }

  static Future<void> openBoxes() async {
    Box<Category> boxCategoria = await Hive.openBox<Category>('categoria');
    Get.put<Box<Category>>(
      boxCategoria,
      tag: Constants.categoriaHive,
      permanent: true,
    );
    Box<Menu> boxMenu = await Hive.openBox<Menu>('menu');
    Get.put<Box<Menu>>(boxMenu, tag: Constants.menuHive, permanent: true);
  }

  static Future<void> initCache({bool refresh = false}) async {
    final hive = Get.find<Box<Category>>(tag: Constants.categoriaHive);
    await Get.find<Box<Menu>>(tag: Constants.menuHive).clear();
    // if (refresh) {
    //   await hive.clear();
    // }
    // if (hive.length == 0) {
    final categorias = await Get.put(
      CardapioController(
        service: Get.put(
          CardapioService(
            repository: Get.put(CardapioRepository()),
          ),
        ),
      ),
    ).getCategorias();
    await hive.clear();
    await hive.addAll(categorias);
    // }
  }
}
