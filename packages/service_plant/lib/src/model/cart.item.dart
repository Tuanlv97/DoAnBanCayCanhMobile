// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'plant.model.dart';

class CartItem {
  int? id;
  int? idPlant;
  int? idUser;
  PlantModel? plant;
  int? number;
  CartItem({
    this.id,
    this.idPlant,
    this.idUser,
    this.plant,
    this.number,
  });

  CartItem copyWith({
    int? id,
    int? idPlant,
    int? idUser,
    PlantModel? plant,
    int? number,
  }) {
    return CartItem(
      id: id ?? this.id,
      idPlant: idPlant ?? this.idPlant,
      idUser: idUser ?? this.idUser,
      plant: plant ?? this.plant,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idPlant': idPlant,
      'idUser': idUser,
      'plant': plant?.toMap(),
      'number': number,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] != null ? map['id'] as int : null,
      idPlant: map['idPlant'] != null ? map['idPlant'] as int : null,
      idUser: map['idUser'] != null ? map['idUser'] as int : null,
      plant: map['plant'] != null ? PlantModel.fromMap(map['plant'] as Map<String,dynamic>) : null,
      number: map['number'] != null ? map['number'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) => CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  int totalPoint() {
    int point = plant?.price ?? 0;
    int count = number ?? 0;
    return point * count;
  }
}
