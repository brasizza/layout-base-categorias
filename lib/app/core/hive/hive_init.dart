import 'dart:developer' as developer;

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:cardapio/app/data/model/menu.dart';
import 'package:cardapio/app/data/repository/cardapio_repository.dart';
import 'package:cardapio/app/data/service/cardapio_service.dart';
import 'package:cardapio/app/modules/home/controllers/cardapio_controller.dart';

import '../../data/model/categoria.dart';
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
    Hive.registerAdapter(CategoriaAdapter());
    Hive.registerAdapter(MenuAdapter());
  }

  static Future<void> openBoxes() async {
    Box<Categoria> boxCategoria = await Hive.openBox<Categoria>('categoria');
    Get.put<Box<Categoria>>(
      boxCategoria,
      tag: Constants.categoriaHive,
      permanent: true,
    );
    Box<Menu> boxMenu = await Hive.openBox<Menu>('menu');
    Get.put<Box<Menu>>(
      boxMenu,
      tag: Constants.menuHive,
      permanent: true,
    );
  }

  static Future<void> initCache({bool refresh = false}) async {
    final hive = Get.find<Box<Categoria>>(tag: Constants.categoriaHive);
    final boxMenu = Get.find<Box<Menu>>(tag: Constants.menuHive);

    if (refresh) {
      await hive.clear();
    }

    developer.log('${hive.length}', name: 'init | hive | antes:');
    developer.log('${boxMenu.length}', name: 'boxMenu | antes:');

    if (hive.length == 0) {
      await boxMenu.clear();
      final categorias = await Get.put(
        CardapioController(
          service: Get.put(
            CardapioService(
              repository: Get.put(CardapioRepository()),
            ),
          ),
        ),
      ).getCategorias(boxMenu: boxMenu);

      developer.log('${hive.length}', name: 'clear | hive | depois:');
      developer.log('${boxMenu.length}', name: 'boxMenu | depois:');

      await hive.clear();
      await hive.addAll(categorias);
      developer.log('${hive.length}', name: 'addAll | hive | depois:');
    }
  }
}
