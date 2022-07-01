import 'package:badges/badges.dart';
import 'package:cardapio/app/modules/extrato/views/extrato_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cardapio/app/modules/extrato/controllers/extrato_controller.dart';
import 'package:cardapio/app/modules/home/controllers/menu_controller.dart';
import 'package:cardapio/app/modules/home/views/components/lista_itens.dart';
import 'package:cardapio/app/modules/home/views/components/top_menu.dart';

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
                  padding: const EdgeInsets.all(8),
                  child: TopMenu(menus: Get.find<MenuController>().menu),
                ),
                Expanded(
                  child: ListaItens(categoria: categorias!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(5),
        height: 80,
        width: 80,
        child: FittedBox(
          child: Obx(
            () => Badge(
              badgeColor: Colors.deepOrange,
              animationType: BadgeAnimationType.slide,
              position: BadgePosition.bottomEnd(bottom: 0, end: 0),
              showBadge: (Get.find<ExtratoController>().extrato?.quantidade ?? 0) > 0,
              badgeContent: Text(
                Get.find<ExtratoController>().extrato?.quantidade.toString() ?? '1',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: (Colors.deepOrange.computeLuminance() > 0.5) ? Colors.black : Colors.white,
                ),
              ),
              child: FloatingActionButton(
                highlightElevation: 20,
                elevation: 10,
                backgroundColor: Colors.black,
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () async {
                  Get.bottomSheet(
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: Get.height * .6,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: const ExtratoView(),
                      ),
                    ),
                    ignoreSafeArea: true,
                    isScrollControlled: true,
                  );
                },
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), //shape of notch
        color: Get.theme.primaryColorDark,
        notchMargin: 2,
        child: Container(
          height: 50,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
