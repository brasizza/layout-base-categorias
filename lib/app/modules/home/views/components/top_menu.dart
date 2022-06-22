import 'package:cardapio/app/data/model/categoria.dart';
import 'package:cardapio/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopMenu extends StatelessWidget {
  final List<Categoria>? categorias;
  final int selectedMenu;
  const TopMenu({Key? key, required this.selectedMenu, required this.categorias}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categorias?.length ?? 0,
          itemBuilder: (_, index) {
            final categoria = categorias![index];
            return Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: (selectedMenu == index) ? Colors.amber : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  Get.find<HomeController>().cardapioIndex = index;
                },
                child: Text(categoria.nome),
              ),
            );
          }),
    );
  }
}
