// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Item {
  final String id;
  final String nome;
  final String imagem;
  final double valor;
  Item({
    required this.id,
    required this.nome,
    required this.imagem,
    required this.valor,
  });

  Item copyWith({
    String? id,
    String? nome,
    String? imagem,
    double? valor,
  }) {
    return Item(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      imagem: imagem ?? this.imagem,
      valor: valor ?? this.valor,
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
