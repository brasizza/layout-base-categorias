import 'package:cardapio/app/modules/home/views/components/lista_itens.dart';
import 'package:cardapio/app/modules/home/views/components/top_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: controller.obx((categorias) {
      return SafeArea(
        child: Column(
          children: [
            Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TopMenu(categorias: categorias, selectedMenu: controller.cardapioIndex),
                )),
            Expanded(child: Obx(() => ListaItens(categoria: categorias![controller.cardapioIndex]))),
          ],
        ),
      );
    }));
  }
}
