import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:cardapio/app/data/model/categoria.dart';
import 'package:cardapio/app/data/model/menu.dart';
import 'package:cardapio/app/data/repository/cardapio_repository.dart';

class CardapioService extends GetxService {
  final CardapioRepository repository;

  CardapioService({
    required this.repository,
  });

  Future<List<Categoria>> getCategorias({required Box<Menu> boxMenu}) async {
    return await repository.getCategorias(boxMenu: boxMenu);
  }

  Future<Category?> getCategoriaHive({required int index}) async {
    return await repository.getCategoriaHive(index: index);
  }

  Future<List<Category>> getAllHive() async {
    return await repository.getAllHive();
  }
}
