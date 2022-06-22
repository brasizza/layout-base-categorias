import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:get/get.dart';

import 'package:cardapio/app/core/extensions/numbers.dart';

import '../controllers/detalhe_item_controller.dart';

class DetalheItemView extends GetView<DetalheItemController> {
  const DetalheItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = controller.item.imagem;

    return Card(
      child: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  controller.item.nome,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 4),
                child: Text(
                  controller.item.valor.formatCurrency(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CachedNetworkImage(
                  imageUrl: 'https://picsum.photos/seed/$image/400',
                  width: 150,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Padding(
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
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Valor Total\n',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: controller.valorItem.formatCurrency().toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width * .8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                    vertical: 10,
                  ),
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
                  child: const Text('Adicionar ao carrinho'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
