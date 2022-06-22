import 'package:badges/badges.dart';
import 'package:cardapio/app/modules/home/controllers/extrato_controller.dart';
import 'package:cardapio/app/modules/home/controllers/menu_controller.dart';
import 'package:cardapio/app/modules/home/views/components/lista_itens.dart';
import 'package:cardapio/app/modules/home/views/components/top_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (categorias) {
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TopMenu(menus: Get.find<MenuController>().menu),
                ),
                Expanded(child: ListaItens(categoria: categorias!)),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          padding: const EdgeInsets.all(5),
          height: 80.0,
          width: 80.0,
          child: FittedBox(
              child: Obx(() => Badge(
                    showBadge: (Get.find<ExtratoController>().extrato?.quantidade ?? 0) > 0,
                    badgeContent: Text(Get.find<ExtratoController>().extrato?.quantidade.toString() ?? '1'),
                    child: FloatingActionButton(
                      highlightElevation: 20.0,
                      elevation: 10,
                      backgroundColor: Colors.black,
                      child: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () async {},
                    ),
                  )))),
      bottomNavigationBar: Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        child: const Text('a'),
      ),
    );
  }
}
