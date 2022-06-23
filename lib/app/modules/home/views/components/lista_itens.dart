import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cardapio/app/data/model/category.dart';
import 'package:cardapio/app/modules/detalhe_item/controllers/detalhe_item_controller.dart';
import 'package:cardapio/app/modules/detalhe_item/views/detalhe_item_view.dart';
import 'package:cardapio/app/modules/home/controllers/home_controller.dart';

import 'product_tile.dart';

class ListaItens extends StatelessWidget {
  final Category categoria;

  const ListaItens({
    Key? key,
    required this.categoria,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
      child: SizedBox(
        width: Get.width,
        child: RefreshIndicator(
          onRefresh: () => Get.find<HomeController>().invalidateCache(),
          child: GridView.builder(
            itemCount: categoria.itens.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 4 / 5,
            ),
            itemBuilder: (context, index) {
              final item = categoria.itens[index];
              return ProductTile(
                image: item.imagem,
                text: item.nome,
                price: item.valor,
                onTap: () {
                  Get.lazyPut<DetalheItemController>(
                    () => DetalheItemController()..item = item,
                  );
                  Get.bottomSheet(
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: Get.height * .6,
                        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                        child: const DetalheItemView(),
                      ),
                    ),
                    ignoreSafeArea: true,
                    isScrollControlled: true,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
