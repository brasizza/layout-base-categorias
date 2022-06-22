import 'package:cardapio/app/core/hive/hive_init.dart';
import 'package:cardapio/app/data/model/categoria.dart';
import 'package:cardapio/app/modules/home/controllers/cardapio_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin<Categoria?> {
  // final _cardapioIndex = 0.obs;
  // int get cardapioIndex => _cardapioIndex.value;
  // set cardapioIndex(int index) => _cardapioIndex(index);

  @override
  void onInit() {
    getItens();
    super.onInit();
  }

  void getItens({int index = 0}) {
    final cardapioController = Get.find<CardapioController>();
    cardapioController.getCategoriaHive(index: index).then((resp) {
      change(resp, status: RxStatus.success());
    }, onError: (err) {
      change(
        null,
        status: RxStatus.error('Error get data'),
      );
    });
  }

  Future invalidateCache() async {
    change(null, status: RxStatus.loading());
    await HiveInit.initCache(refresh: true);
    getItens();
  }
}
