import 'package:cardapio/app/data/repository/cardapio_repository.dart';
import 'package:cardapio/app/data/service/cardapio_service.dart';
import 'package:cardapio/app/modules/home/controllers/cardapio_controller.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  }

  static Future<void> openBoxes() async {
    Box<Categoria> boxCategoria = await Hive.openBox<Categoria>('categoria');
    Get.put<Box<Categoria>>(boxCategoria, tag: Constants.categoriaHive, permanent: true);
  }

  static Future<void> initCache({bool refresh = false}) async {
    final hive = Get.find<Box<Categoria>>(tag: Constants.categoriaHive);
    if (refresh) {
      await hive.clear();
    }
    if (hive.length == 0) {
      final categorias = await Get.put(
        CardapioController(
          service: Get.put(
            CardapioService(
              repository: Get.put(
                CardapioRepository(),
              ),
            ),
          ),
        ),
      ).getCategorias();
      await hive.clear();
      await hive.addAll(categorias);
    }
  }
}
