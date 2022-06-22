import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:cardapio/app/data/model/item.dart';

class Extrato {
  List<Item>? items;
  int? quantidade = 0;
  double? somaTotal = 0.00;
  String? codTransacao;

  Extrato({
    this.items,
    this.quantidade,
    this.somaTotal,
    this.codTransacao,
  });
  // Hive fields go here

  Extrato copyWith({
    List<Item>? items,
    int? quantidade,
    double? somaTotal,
  }) {
    return Extrato(
      items: items ?? this.items,
      quantidade: quantidade ?? this.quantidade,
      somaTotal: somaTotal ?? this.somaTotal,
      codTransacao: codTransacao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'items': (items == null) ? null : items!.map((x) => x.toMap()).toList(),
      'quantidade': quantidade,
      'somaTotal': somaTotal,
      'codTransacao': codTransacao,
    };
  }

  factory Extrato.fromMap(Map<String, dynamic> map) {
    return Extrato(
      items: map['items'] != null
          ? List<Item>.from(
              (map['items'] as List<int>).map<Item?>(
                (x) => Item.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      quantidade: map['quantidade'] as int,
      somaTotal: map['somaTotal'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Extrato.fromJson(String source) =>
      Extrato.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Extrato(items: $items, quantidade: $quantidade, somaTotal: $somaTotal)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Extrato &&
        listEquals(other.items, items) &&
        other.quantidade == quantidade &&
        other.somaTotal == somaTotal &&
        other.codTransacao == codTransacao;
  }

  @override
  int get hashCode =>
      items.hashCode ^
      quantidade.hashCode ^
      somaTotal.hashCode ^
      codTransacao.hashCode;
}
