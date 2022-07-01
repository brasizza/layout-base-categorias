import 'package:get/get.dart';

import 'package:cardapio/app/data/model/item.dart';
import 'package:cardapio/app/modules/extrato/controllers/extrato_controller.dart';

class DetalheItemController extends GetxController {
  final _quantidade = 1.obs;
  int get quantidade => _quantidade.value;
  set quantidade(int quantidade) {
    _quantidade(quantidade);
    _recalcularValor();
  }

  final _valorItem = 0.0.obs;
  double get valorItem => _valorItem.value;
  final _item = Rxn<Item>();
  set item(Item item) {
    _item(item);
  }

  Item get item => _item.value!;

  @override
  void onInit() {
    _valorItem(item.valor * quantidade);
    _recalcularValor();
    super.onInit();
  }

  _recalcularValor() {
    _valorItem(item.valor * quantidade);
  }

  Future<void> vender() async {
    final itemVenda = item.copyWith(quantidade: quantidade);
    Get.find<ExtratoController>().venderItem(itemVenda);
  }
}
