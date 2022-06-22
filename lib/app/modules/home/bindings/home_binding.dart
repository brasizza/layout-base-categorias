import 'package:cardapio/app/data/repository/cardapio_repository.dart';
import 'package:cardapio/app/data/service/cardapio_service.dart';
import 'package:cardapio/app/modules/home/controllers/cardapio_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CardapioRepository>(CardapioRepository());
    Get.put<CardapioService>(CardapioService(repository: Get.find<CardapioRepository>()));
    Get.put<CardapioController>(CardapioController(service: Get.find<CardapioService>()));
    Get.put<HomeController>(HomeController());
  }
}
