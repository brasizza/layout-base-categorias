import 'package:cached_network_image/cached_network_image.dart';
import 'package:cardapio/app/core/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cardapio/app/data/model/extrato.dart';
import 'package:cardapio/app/data/model/item.dart';
import 'package:uuid/uuid.dart';

class ExtratoController extends GetxController {
  final _extrato = Rxn<Extrato>();
  Extrato? get extrato => _extrato.value;

  Future<void> calculaExtrato() async {
    if (_extrato.value!.items != null) {
      _extrato.value!.quantidade = 0;
      _extrato.value!.somaTotal = 0;
      for (var item in _extrato.value!.items!) {
        _extrato.value!.quantidade = _extrato.value!.quantidade! + (item.quantidade ?? 1);
        _extrato.value!.somaTotal = _extrato.value!.somaTotal! + ((item.quantidade ?? 1) * item.valor);
      }
    }
    _extrato.refresh();
  }

  void venderItem(Item item) async {
    if (_extrato.value == null) {
      _extrato(
        Extrato(
          codTransacao: const Uuid().v4(),
          items: [item],
        ),
      );
    } else {
      final existe = _extrato.value!.items?.indexOf(item);

      if ((existe ?? -1) >= 0) {
        _extrato.value!.items![existe!].quantidade = _extrato.value!.items![existe].quantidade! + item.quantidade!;
      } else {
        _extrato.value!.items!.add(item);
      }
    }
    calculaExtrato();
  }

  void atualizarItem(int index, int qtd) {
    _extrato.value?.items?[index].quantidade = qtd;
    calculaExtrato();
  }

  deletarItem(int index) {
    _extrato.value?.items?.removeAt(index);
    calculaExtrato();
    if (_extrato.value!.items!.isEmpty) {
      _extrato(null);
      Get.close(0);
    }
  }

  Future<bool> dialogRemoverItem(Item item) async {
    return await Get.defaultDialog(
      title: 'Remover item',
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: 'https://picsum.photos/seed/${item.imagem.onlyNumber()}/400',
            width: 100,
            imageBuilder: (context, imageProvider) => Container(
              width: 100,
              height: 100,
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
          ),
          Text(
            "Deseja realmente remover ${item.nome}? ",
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: const Text('Sim'),
        ),
        OutlinedButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: const Text('Não'),
        ),
      ],
    );
  }
}
