// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cardapio/app/data/model/item.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'categoria.g.dart';

@HiveType(typeId: 1)
class Categoria {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? codigo;

  @HiveField(2)
  final String nome;

  @HiveField(3)
  List<Item> itens;

  Categoria({
    required this.id,
    this.codigo,
    required this.nome,
    required this.itens,
  });

  Categoria copyWith({
    String? id,
    String? codigo,
    String? nome,
    List<Item>? itens,
  }) {
    return Categoria(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      itens: itens ?? this.itens,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'codigo': codigo,
      'nome': nome,
      'itens': itens.map((x) => x.toMap()).toList(),
    };
  }

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'] as String,
      codigo: map['codigo'] != null ? map['codigo'] as String : null,
      nome: map['nome'] as String,
      itens: List<Item>.from(
        (map['itens'] as List<dynamic>).map<Item>(
          (x) => Item.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Categoria.fromJson(String source) => Categoria.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Categoria(id: $id, codigo: $codigo, nome: $nome, itens: $itens)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Categoria && other.id == id && other.codigo == codigo && other.nome == nome && listEquals(other.itens, itens);
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ nome.hashCode ^ itens.hashCode;
  }
}
