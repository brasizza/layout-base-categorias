// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cardapio/app/data/model/categoria.dart';
import 'package:cardapio/app/data/service/cardapio_service.dart';
import 'package:get/get.dart';

class CardapioController extends GetxController {
  final CardapioService service;
  CardapioController({
    required this.service,
  });

  Future<List<Categoria>> getCategorias() async {
    return await service.getCategorias();
  }

  Future<List<Categoria>> getCategoriasHive() async {
    return await service.getCategoriasHive();
  }
}
