import 'dart:convert';
import 'dart:developer';

import 'package:get/get_connect/connect.dart';
import 'package:get/instance_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:cardapio/app/core/constants.dart';
import 'package:cardapio/app/data/model/categoria.dart';
import 'package:cardapio/app/data/model/menu.dart';

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class CardapioRepository extends GetConnect {
  final dadosJson = Constants.datasJson;

  Future<List<Categoria>> getCategorias() async {
    log('PEGANDO DO JSON');
    final boxMenu = Get.find<Box<Menu>>(tag: Constants.menuHive);
    Map<String, dynamic> dadosApi = json.decode(dadosJson);
    final categorias = <Categoria>[];
    for (var item in dadosApi['categorias']) {
      categorias.add(Categoria.fromMap(item));
      boxMenu.add(Menu.fromMap(item));
    }
    return categorias;
  }

  Future<List<Categoria>> getAllHive() async {
    log('PEGANDO DO HIVE');
    final box = Get.find<Box<Categoria>>(tag: Constants.categoriaHive);
    return box.values.toList();
  }

  Future<Categoria?> getCategoriaHive({required int index}) async {
    log('PEGANDO DO HIVE');
    final box = Get.find<Box<Categoria>>(tag: Constants.categoriaHive);
    return box.getAt(index);
  }
}
