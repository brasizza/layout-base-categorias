import 'package:cardapio/app/data/model/categoria.dart';
import 'package:cardapio/app/modules/home/controllers/cardapio_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin<List<Categoria>> {
  final _cardapioIndex = 0.obs;
  int get cardapioIndex => _cardapioIndex.value;

  set cardapioIndex(int index) => _cardapioIndex(index);

  @override
  void onInit() {
    final cardapioController = Get.find<CardapioController>();
    cardapioController.getCategorias().then((resp) {
      change(resp, status: RxStatus.success());
    }, onError: (err) {
      print(err);
      change(
        null,
        status: RxStatus.error('Error get data'),
      );
      super.onInit();
    });
  }
}
