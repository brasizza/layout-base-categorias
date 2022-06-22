import 'package:cardapio/app/data/model/categoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_tile.dart';

class ListaItens extends StatelessWidget {
  final Categoria categoria;
  const ListaItens({Key? key, required this.categoria}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        width: Get.width,
        child: GridView.builder(
          itemCount: categoria.itens.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 4 / 5,
          ),
          itemBuilder: (context, index) {
            final product = categoria.itens[index];
            return ProductTile(
              image: product.imagem,
              text: product.nome,
              price: product.valor,
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
