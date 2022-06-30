import 'dart:convert';
import 'dart:developer' as developer;

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:cardapio/app/core/constants.dart';
import 'package:cardapio/app/data/model/categoria.dart';
import 'package:cardapio/app/data/model/menu.dart';

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class CardapioRepository {
  Future<List<Categoria>> getCategorias({required Box<Menu> boxMenu}) async {
    const dadosJson = Constants.datasJson;
    try {
      developer.log('PEGANDO DO JSON', name: 'get JSON');
      final boxMenu = Get.find<Box<Menu>>(tag: Constants.menuHive);
      Map<String, dynamic> dadosApi = json.decode(dadosJson);
      final categorias = <Categoria>[];
      for (var categoria in dadosApi['categorias']) {
        categorias.add(Categoria.fromMap(categoria));
        boxMenu.add(Menu.fromMap(categoria));
      }
      return categorias;
    } catch (e, s) {
      developer.log('$e');
      developer.log('$s');
      throw Exception('Error in getCategorias');
    }
  }

  Future<List<Categoria>> getAllHive() async {
    developer.log('PEGANDO DO HIVE');
    final box = Get.find<Box<Categoria>>(tag: Constants.categoriaHive);
    return box.values.toList();
  }

  Future<Categoria?> getCategoriaHive({required int index}) async {
    developer.log('PEGANDO DO HIVE');
    final box = Get.find<Box<Categoria>>(tag: Constants.categoriaHive);
    return box.getAt(index);
  }
}
