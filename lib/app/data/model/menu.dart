import 'dart:convert';

import 'package:hive/hive.dart';

part 'menu.g.dart';

@HiveType(typeId: 3)
class Menu extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? codigo;
  @HiveField(2)
  final String nome;

  Menu({
    required this.id,
    this.codigo,
    required this.nome,
  });
  // Hive fields go here

  Menu copyWith({
    String? id,
    String? codigo,
    String? nome,
  }) {
    return Menu(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'codigo': codigo,
      'nome': nome,
    };
  }

  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      id: map['id'] as String,
      codigo: map['codigo'] != null ? map['codigo'] as String : null,
      nome: map['nome'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Menu.fromJson(String source) =>
      Menu.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Menu(id: $id, codigo: $codigo, nome: $nome)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Menu &&
        other.id == id &&
        other.codigo == codigo &&
        other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;
}
