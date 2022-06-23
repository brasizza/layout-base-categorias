import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String nome;
  @HiveField(2)
  final String imagem;
  @HiveField(3)
  double valor;
  @HiveField(4)
  int? quantidade;

  Item({
    required this.id,
    required this.nome,
    required this.imagem,
    required this.valor,
    this.quantidade = 0,
  });

  Item copyWith({
    String? id,
    String? nome,
    String? imagem,
    double? valor,
    int? quantidade,
  }) {
    return Item(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      imagem: imagem ?? this.imagem,
      valor: valor ?? this.valor,
      quantidade: quantidade ?? this.quantidade,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'imagem': imagem,
      'valor': valor,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as String,
      nome: map['nome'] as String,
      imagem: map['imagem'] as String,
      valor: double.parse(map['valor'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item(id: $id, nome: $nome, imagem: $imagem, valor: $valor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item && other.id == id && other.nome == nome && other.imagem == imagem && other.valor == valor;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nome.hashCode ^ imagem.hashCode ^ valor.hashCode;
  }
}
