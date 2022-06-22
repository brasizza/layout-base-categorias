import 'dart:convert';
import 'dart:developer';

import 'package:cardapio/app/core/constants.dart';
import 'package:cardapio/app/data/model/categoria.dart';
import 'package:cardapio/app/data/model/menu.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/instance_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class CardapioRepository extends GetConnect {
  final dadosJson =
      '{"categorias":[{"id":"00000000-0000-0000-0000-000000000000","nome":"Favoritos","itens":[{"id":"1ce403e1-36cf-4a8b-83a3-81277d3258b9","nome":"Bacon Burger","imagem":"749a9996-6d6d-4d72-be2f-797281dcb1c4.png","valor":10},{"id":"21be66ad-672b-4485-8356-ffb7a6bcf6a1","nome":"Suco de Laranja","imagem":"0f3909e5-96ec-42c4-ae32-03e0c028d870.png","valor":6},{"id":"71b4ec82-1165-4e13-b4eb-0245a3b0b06d","nome":"Super Dog","imagem":"f7ee8bca-0e3e-4a2d-9a94-6a9f5991825c.png","valor":8},{"id":"8b1d11e5-dea6-4f51-85d0-9c745ff2ddde","nome":"Água Mineral Perrier","imagem":"2ae4b03f-d628-47ec-85ed-496e3aff7859.png","valor":7},{"id":"3be77e39-d35f-4e06-ad0f-3cf7beeb3693","nome":"Coca-Cola","imagem":"43e4fe77-ac48-43ad-979a-899cf9613f5c.png","valor":4.5},{"id":"c65d964c-824e-4b8d-9205-c6506ed99126","nome":"Amor de Chocolate","imagem":"0ae51528-81f1-495b-963f-82231ea45acf.png","valor":17},{"id":"dfb479c6-f580-46de-9ae2-1b47ae2c9ff2","nome":"Café Capuccino","imagem":"8a12fc67-827a-4a57-8889-846afd7c3e0a.png","valor":3},{"id":"40ae8226-682a-4317-a900-05e4fd701a1d","nome":"Café Suíço","imagem":"8a3d8644-e6c6-47e8-b9a1-34614df516d4.png","valor":1},{"id":"b1e7944f-46a1-48ab-8e89-85e4fbc96104","nome":"Caldo de Cana","imagem":"8ab78590-d054-4617-be4d-f2352d40d5f7.png","valor":10},{"id":"c26325d9-9b49-4d41-bce4-4e1f9e04fa59","nome":"Red Bull","imagem":"9e7be694-70a1-4b63-baa7-08cb3f987fbd.png","valor":4},{"id":"ac3b2e23-f635-408f-afc9-ce18d06ca86c","nome":"Sopa Haiti","imagem":"22b1e7be-e938-4234-843e-2f32871078a4.png","valor":13},{"id":"d2c79a43-c5e0-4db5-b15b-b17e59c1a551","nome":"Sopa Itália","imagem":"fa699fb1-1f9f-4800-818e-f2fc12daff9b.png","valor":12},{"id":"e6d7c458-7004-474c-9697-6e79eee2e6ed","nome":"Sorvete Cone","imagem":"4f900eda-90c1-4db8-8bc5-0288d7f13d82.png","valor":5},{"id":"b9c811a3-021f-4128-a474-ecad2a53c0a9","nome":"Suco de Cajá","imagem":"92f9b26c-d80a-417b-96fe-596996055fe2.png","valor":5},{"id":"5658808a-433f-4795-8135-432b8c8f1eab","nome":"Suco de Cajú","imagem":"a9e16d75-9fed-428a-8171-da1402622005.png","valor":5}]},{"id":"b432e1d0-2db3-43b7-b465-793d5adbbcaa","codigo":"1","nome":"Sanduíches","itens":[{"id":"1ce403e1-36cf-4a8b-83a3-81277d3258b9","nome":"Bacon Burger","imagem":"749a9996-6d6d-4d72-be2f-797281dcb1c4.png","valor":10},{"id":"bc65d32e-f025-4846-ac7a-f54175f2d3bc","nome":"Bacon Burger Duplo","imagem":"e00c7d87-04bf-49e7-86ec-d96735614eb7.png","valor":17},{"id":"eecfd7a3-f075-4d5a-8430-1365fb8f0c28","nome":"Bacon Burger Triplo","imagem":"ade963f5-6aa1-484d-b438-40c28f773d39.png","valor":16},{"id":"71b4ec82-1165-4e13-b4eb-0245a3b0b06d","nome":"Super Dog","imagem":"f7ee8bca-0e3e-4a2d-9a94-6a9f5991825c.png","valor":8},{"id":"646a3764-0fa1-4b6f-89ac-3e197088cf50","nome":"Hamburger","imagem":"abcc4d73-98c5-47ff-9e92-1ebcbcbaaa73.png","valor":12}]},{"id":"cb6f3972-d494-4554-9210-867cd3320763","codigo":"2","nome":"Sopas","itens":[{"id":"baa2f145-4b83-403a-a8e5-688bb27aff1d","nome":"Sopa América","imagem":"45cc34aa-2954-49aa-8a93-ebdf4bb579d4.png","valor":15},{"id":"d983e7b8-6534-422a-ac5b-73d2bd482884","nome":"Sopa Equador","imagem":"fb93855c-d856-4020-a03f-9b200e3ebeb8.png","valor":13},{"id":"1886f487-3c15-4f36-b651-07e303a2b81b","nome":"Sopa Fiji","imagem":"ebbbc85a-240f-4a75-87a0-00ded5b7e3f3.png","valor":12},{"id":"9dc90cac-f4ac-4597-a789-00f502e49d75","nome":"Sopa França","imagem":"5528b734-6eb5-497c-8c77-383b5f5070ce.png","valor":15},{"id":"ac3b2e23-f635-408f-afc9-ce18d06ca86c","nome":"Sopa Haiti","imagem":"22b1e7be-e938-4234-843e-2f32871078a4.png","valor":13},{"id":"d2c79a43-c5e0-4db5-b15b-b17e59c1a551","nome":"Sopa Itália","imagem":"fa699fb1-1f9f-4800-818e-f2fc12daff9b.png","valor":12},{"id":"06353791-4723-4fcf-b770-403a01662ce4","nome":"Sopa Marrocos","imagem":"680f4a93-9614-4315-9c50-f748a8166898.png","valor":15},{"id":"320b1bd9-55e7-4ab8-9755-ca97c988f3ab","nome":"Sopa México","imagem":"ec502cd3-8e35-4c71-923b-0c7be55eca7a.png","valor":12},{"id":"a67709cb-201f-4178-bf6d-5f2a94be8d91","nome":"Sopa Tailândia","imagem":"104f07c0-467a-4bfa-8592-066b32d11f08.png","valor":14}]},{"id":"e7397200-ed10-4699-bbaa-43407c6484f5","codigo":"3","nome":"Sucos","itens":[{"id":"21be66ad-672b-4485-8356-ffb7a6bcf6a1","nome":"Suco de Laranja","imagem":"0f3909e5-96ec-42c4-ae32-03e0c028d870.png","valor":6},{"id":"b1e7944f-46a1-48ab-8e89-85e4fbc96104","nome":"Caldo de Cana","imagem":"8ab78590-d054-4617-be4d-f2352d40d5f7.png","valor":10},{"id":"aa8e2b29-6c22-4472-be6b-54a8778f227e","nome":"Suco de Abacaxi","imagem":"a8c9f042-7dd8-4339-9e1d-894fbed127dc.png","valor":6},{"id":"b9c811a3-021f-4128-a474-ecad2a53c0a9","nome":"Suco de Cajá","imagem":"92f9b26c-d80a-417b-96fe-596996055fe2.png","valor":5},{"id":"5658808a-433f-4795-8135-432b8c8f1eab","nome":"Suco de Cajú","imagem":"a9e16d75-9fed-428a-8171-da1402622005.png","valor":5},{"id":"186ad288-2294-479e-92b4-089ed35d65b7","nome":"Suco de Graviola","imagem":"59f74812-6149-4496-8f35-11a38b2a22ce.png","valor":6},{"id":"b9d05638-70e0-44af-8303-b2d7f3c5e1f8","nome":"Suco de Manga","imagem":"d8e4173a-4559-45d7-8dd8-f30a6a8262ee.png","valor":7}]},{"id":"eec15e63-ea13-48b8-aca5-ef25e2f17952","codigo":"4","nome":"Refrigerantes","itens":[{"id":"8b1d11e5-dea6-4f51-85d0-9c745ff2ddde","nome":"Água Mineral Perrier","imagem":"2ae4b03f-d628-47ec-85ed-496e3aff7859.png","valor":7},{"id":"3be77e39-d35f-4e06-ad0f-3cf7beeb3693","nome":"Coca-Cola","imagem":"43e4fe77-ac48-43ad-979a-899cf9613f5c.png","valor":4.5},{"id":"4185819f-c094-49cb-ac82-831783fe871d","nome":"Coca-Cola Zero","imagem":"b3c296d9-0d0c-4570-9b68-1eec196eb78c.png","valor":4},{"id":"c5025642-105f-499b-be66-c3aead8a27da","nome":"Fanta Laranja","imagem":"8923569a-afe7-4785-a36a-581c5467f52b.png","valor":5},{"id":"02d3b2ee-4e77-4423-a4b3-be5d2f759598","nome":"Fanta Uva","imagem":"5aa7c19a-3592-4b4a-aa51-5f33868b5542.png","valor":5},{"id":"309b6095-faad-48ee-8b40-04af2d758b45","nome":"Guaraná Antarctica","imagem":"e9100c20-9214-4637-9b51-1254561bab07.jpg","valor":5},{"id":"c26325d9-9b49-4d41-bce4-4e1f9e04fa59","nome":"Red Bull","imagem":"9e7be694-70a1-4b63-baa7-08cb3f987fbd.png","valor":4},{"id":"c2f41e14-e8ab-4541-a3fd-a1c8ef4bf2ef","nome":"Sprite","imagem":"4eba2d7a-5247-4273-be12-1ec70d379d6a.png","valor":5}]},{"id":"8f8a1908-0652-44dd-9467-9b4087513be9","codigo":"5","nome":"Cafés","itens":[{"id":"dfb479c6-f580-46de-9ae2-1b47ae2c9ff2","nome":"Café Capuccino","imagem":"8a12fc67-827a-4a57-8889-846afd7c3e0a.png","valor":3},{"id":"d3f605c9-ecd9-46e5-94f9-863441257554","nome":"Café Extra Forte","imagem":"05f20e10-db62-4888-89c1-5cba4b5a2ccf.png","valor":1.2},{"id":"40ae8226-682a-4317-a900-05e4fd701a1d","nome":"Café Suíço","imagem":"8a3d8644-e6c6-47e8-b9a1-34614df516d4.png","valor":1}]},{"id":"143aae1b-fe7d-4f7b-b799-05e9702176ac","codigo":"6","nome":"Sobremesas","itens":[{"id":"c65d964c-824e-4b8d-9205-c6506ed99126","nome":"Amor de Chocolate","imagem":"0ae51528-81f1-495b-963f-82231ea45acf.png","valor":17},{"id":"6567d597-9cfd-4350-b33f-50e338956f82","nome":"Picolé Eskibon","imagem":"62591b93-80ee-43fd-8c58-597262361b55.png","valor":6},{"id":"ea97ac45-c0b1-4dc1-b31d-7644b636db64","nome":"Picolé Fruttare","imagem":"508ed5dc-7fb7-4b2d-9150-74d6c9b7ef9b.png","valor":6},{"id":"e6d7c458-7004-474c-9697-6e79eee2e6ed","nome":"Sorvete Cone","imagem":"4f900eda-90c1-4db8-8bc5-0288d7f13d82.png","valor":5},{"id":"473d372c-7f77-400e-8b06-6aa2bc4f7eef","nome":"Sorvete Cornetto","imagem":"94998344-d528-4b96-b96f-dc4ad039e50b.png","valor":7},{"id":"0e51dd13-a058-4ef3-b539-a38a43a866f7","nome":"Sorvete Eskibon","imagem":"36f542bd-ba32-4d61-b6b7-99b3e10f8cdb.png","valor":14},{"id":"30f41494-eefb-4677-b295-7c4cb53dac38","nome":"Sorvete Kibon","imagem":"9f63cfc6-966e-488f-878c-b155f2028b6e.png","valor":6}]}]}';

  Future<List<Categoria>> getCategorias() async {
    log('PEGANDO DO JSON');

    final boxMenu = Get.find<Box<Menu>>(tag: Constants.menuHive);

    Map<String, dynamic> dadosApi = json.decode(dadosJson);
    final categorias = <Categoria>[];

    for (var item in dadosApi['categorias']) {
      categorias.add(Categoria.fromMap(item));
      boxMenu.add(Menu.fromMap(item));
    }
    return categorias;
  }

  Future<List<Categoria>> getAllHive() async {
    log('PEGANDO DO HIVE');
    final box = Get.find<Box<Categoria>>(tag: Constants.categoriaHive);

    return box.values.toList();
  }

  Future<Categoria?> getCategoriaHive({required int index}) async {
    log('PEGANDO DO HIVE');
    final box = Get.find<Box<Categoria>>(tag: Constants.categoriaHive);

    return box.getAt(index);
  }
}
