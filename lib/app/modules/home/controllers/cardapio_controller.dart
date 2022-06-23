import 'package:get/get.dart';

import 'package:cardapio/app/data/model/category.dart';
import 'package:cardapio/app/data/service/cardapio_service.dart';

class CardapioController extends GetxController {
  final CardapioService service;

  CardapioController({
    required this.service,
  });

  Future<List<Category>> getCategorias() async {
    return await service.getCategorias();
  }

  Future<Category?> getCategoriaHive({required int index}) async {
    return await service.getCategoriaHive(index: index);
  }

  Future<List<Category>> getAllHive() async {
    return await service.getAllHive();
  }
}
