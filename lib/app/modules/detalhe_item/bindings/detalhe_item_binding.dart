import 'package:get/get.dart';

import '../controllers/detalhe_item_controller.dart';

class DetalheItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetalheItemController>(
      () => DetalheItemController(),
    );
  }
}
