import 'package:get/get.dart';

import 'package:cardapio/app/data/model/category.dart';
import 'package:cardapio/app/data/repository/cardapio_repository.dart';

class CardapioService extends GetxService {
  final CardapioRepository repository;

  CardapioService({
    required this.repository,
  });

  Future<List<Category>> getCategorias() async {
    return await repository.getCategorias();
  }

  Future<Category?> getCategoriaHive({required int index}) async {
    return await repository.getCategoriaHive(index: index);
  }

  Future<List<Category>> getAllHive() async {
    return await repository.getAllHive();
  }
}
