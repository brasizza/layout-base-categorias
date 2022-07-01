import 'package:cached_network_image/cached_network_image.dart';
import 'package:cardapio/app/core/extensions/numbers.dart';
import 'package:cardapio/app/core/extensions/string.dart';
import 'package:cardapio/app/data/model/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import 'package:get/get.dart';

import '../controllers/extrato_controller.dart';

class ExtratoView extends GetView<ExtratoController> {
  const ExtratoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Itens consumidos',
        ),
        Obx(
          () => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.builder(
                  itemCount: (controller.extrato?.items?.length) ?? 0,
                  itemBuilder: (context, index) {
                    Item item = controller.extrato!.items![index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Dismissible(
                        key: UniqueKey(),
                        confirmDismiss: (_) async {
                          return controller.dialogRemoverItem(item);
                        },
                        onDismissed: (direction) async {
                          await controller.deletarItem(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
                            GestureDetector(
                                onTap: () {
                                  // Utils.abrirThumbImagem(item.foto!);
                                },
                                child: CachedNetworkImage(
                                  imageUrl: 'https://picsum.photos/seed/${item.imagem.onlyNumber()}/400',
                                  width: 50,
                                  imageBuilder: (context, imageProvider) => Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                    ),
                                  ),
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
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                width: 120,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.nome,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      ((item.valor * item.quantidade!).formatCurrency().toString()),
                                      softWrap: true,
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 120,
                              child: SpinBox(
                                readOnly: true,
                                keyboardType: const TextInputType.numberWithOptions(signed: true),
                                min: 0,
                                spacing: 0,
                                max: 99,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                                value: item.quantidade!.toDouble(),
                                onChanged: (qtd) async {
                                  if (qtd <= 0) {
                                    final remover = await controller.dialogRemoverItem(item);
                                    if (remover) {
                                      await controller.deletarItem(index);
                                    } else {
                                      controller.atualizarItem(index, 1);
                                    }
                                  } else {
                                    controller.atualizarItem(index, qtd.toInt());
                                  }
                                },
                              ),
                            ),
                          ]),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
