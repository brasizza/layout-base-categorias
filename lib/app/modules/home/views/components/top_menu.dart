import 'package:cardapio/app/data/model/menu.dart';
import 'package:cardapio/app/modules/home/controllers/home_controller.dart';
import 'package:cardapio/app/modules/home/controllers/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopMenu extends GetView<MenuController> {
  final List<Menu>? menus;
  const TopMenu({Key? key, required this.menus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: menus?.length ?? 0,
          itemBuilder: (_, index) {
            final categoria = menus![index];
            return Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: (controller.selectedMenu == index) ? Colors.amber : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      controller.selectedMenu = index;
                      Get.find<HomeController>().getItens(index: index);
                    },
                    child: Text(categoria.nome),
                  )),
            );
          }),
    );
  }
}
