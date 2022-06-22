import 'package:cached_network_image/cached_network_image.dart';
import 'package:cardapio/app/core/extensions/numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:get/get.dart';

import '../controllers/detalhe_item_controller.dart';

class DetalheItemView extends GetView<DetalheItemController> {
  const DetalheItemView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                controller.item.nome,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                controller.item.valor.formatCurrency(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: CachedNetworkImage(
                imageUrl: 'https://picsum.photos/seed/${controller.item.imagem}}/400',
                width: 150,
                progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: LinearProgressIndicator(
                      value: downloadProgress.progress,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(Icons.error),
                ),
                fit: BoxFit.cover,
              ),
            ),
            RichText(
                text: TextSpan(children: [
              const TextSpan(
                text: 'Valor total',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              const TextSpan(text: '  '),
              TextSpan(
                text: controller.valorItem.formatCurrency().toString(),
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
            ])),
            SizedBox(
              width: Get.width * .8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                child: SpinBox(
                  min: 1,
                  max: 99,
                  value: controller.quantidade.toDouble(),
                  readOnly: true,
                  digits: 2,
                  onChanged: (quantidade) {
                    controller.quantidade = quantidade.toInt();
                  },
                  decoration: const InputDecoration(labelText: 'Quantidade'),
                ),
              ),
            ),
            SizedBox(
                height: 50,
                child: OutlinedButton(
                    onPressed: () async {
                      await controller.vender();
                      Get.close(0);
                    },
                    child: const Text('Adicionar ao carrinho')))
          ],
        ),
      ),
    );
  }
}
