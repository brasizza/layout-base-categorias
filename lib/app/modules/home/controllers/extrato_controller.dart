import 'package:get/get.dart';

import 'package:cardapio/app/data/model/extrato.dart';
import 'package:cardapio/app/data/model/item.dart';

class ExtratoController extends GetxController {
  final _extrato = Rxn<Extrato>();
  Extrato? get extrato => _extrato.value;

  Future<void> calculaExtrato() async {
    if (_extrato.value!.items != null) {
      _extrato.value!.quantidade = 0;
      _extrato.value!.somaTotal = 0;
      for (var item in _extrato.value!.items!) {
        _extrato.value!.quantidade =
            _extrato.value!.quantidade! + (item.quantidade ?? 1);
        _extrato.value!.somaTotal =
            _extrato.value!.somaTotal! + ((item.quantidade ?? 1) * item.valor);
      }
    }
    _extrato.refresh();
  }

  void venderItem(Item item) async {
    if (_extrato.value == null) {
      _extrato(
        Extrato(
          codTransacao: '123456',
          items: [item],
        ),
      );
    } else {
      _extrato.value?.items?.add(item);
    }
    calculaExtrato();
  }
}
