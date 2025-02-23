// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:service_plant/service_plant.dart';

class BillDetailModel {
  int? id;
  int? idPlant;
  int? idBill;
  PlantModel? plant;
  int? number;
  BillDetailModel({
    this.id,
    this.idPlant,
    this.idBill,
    this.plant,
    this.number,
  });

  BillDetailModel copyWith({
    int? id,
    int? idPlant,
    int? idBill,
    PlantModel? plant,
    int? number,
  }) {
    return BillDetailModel(
      id: id ?? this.id,
      idPlant: idPlant ?? this.idPlant,
      idBill: idBill ?? this.idBill,
      plant: plant ?? this.plant,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idPlant': idPlant,
      'idBill': idBill,
      'number': number,
    };
  }

  factory BillDetailModel.fromMap(Map<String, dynamic> map) {
    return BillDetailModel(
      id: map['id'] != null ? map['id'] as int : null,
      idPlant: map['idPlant'] != null ? map['idPlant'] as int : null,
      idBill: map['idBill'] != null ? map['idBill'] as int : null,
      plant: map['plant'] != null ? PlantModel.fromMap(map['plant'] as Map<String, dynamic>) : null,
      number: map['number'] != null ? map['number'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BillDetailModel.fromJson(String source) => BillDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  int totalPoint() {
    var pointPlant = plant?.price ?? 0;
    var numberPlant = number ?? 0;
    return pointPlant * numberPlant;
  }
}
