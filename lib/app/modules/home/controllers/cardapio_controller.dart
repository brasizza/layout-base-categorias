import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:cardapio/app/data/model/categoria.dart';
import 'package:cardapio/app/data/model/menu.dart';
import 'package:cardapio/app/data/service/cardapio_service.dart';

class CardapioController extends GetxController {
  final CardapioService service;

  CardapioController({
    required this.service,
  });

  Future<List<Categoria>> getCategorias({required Box<Menu> boxMenu}) async {
    return await service.getCategorias(boxMenu: boxMenu);
  }

  Future<Categoria?> getCategoriaHive({required int index}) async {
    return await service.getCategoriaHive(index: index);
  }

  Future<List<Categoria>> getAllHive() async {
    return await service.getAllHive();
  }
}
