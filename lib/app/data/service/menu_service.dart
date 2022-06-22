// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cardapio/app/data/model/menu.dart';
import 'package:cardapio/app/data/repository/menu_repository.dart';
import 'package:get/get.dart';

class MenuService extends GetxService {
  final MenuRepository repository;
  MenuService({
    required this.repository,
  });

  Future<List<Menu>?> buildMenu() async {
    return await repository.buildMenu();
  }
}
