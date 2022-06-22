import 'package:get/get.dart';

import 'package:cardapio/app/data/model/categoria.dart';
import 'package:cardapio/app/data/repository/cardapio_repository.dart';

class CardapioService extends GetxService {
  final CardapioRepository repository;

  CardapioService({
    required this.repository,
  });

  Future<List<Categoria>> getCategorias() async {
    return await repository.getCategorias();
  }

  Future<Categoria?> getCategoriaHive({required int index}) async {
    return await repository.getCategoriaHive(index: index);
  }

  Future<List<Categoria>> getAllHive() async {
    return await repository.getAllHive();
  }
}
