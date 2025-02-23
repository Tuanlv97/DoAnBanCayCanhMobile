// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:service_plant/service_plant.dart';

class PlantModel {
  final int? id;
  final int? idPlantType;
  final PlantTypeModel? plantType;
  final String? name;
  final String? image;
  final String? descriptionDecor;
  final int? price;
  final int? quantity;
  final int? status;
  PlantModel({
    this.id,
    this.idPlantType,
    this.plantType,
    this.name,
    this.image,
    this.descriptionDecor,
    this.price,
    this.quantity,
    this.status,
  });

  PlantModel copyWith({
    int? id,
    int? idPlantType,
    PlantTypeModel? plantType,
    String? name,
    String? image,
    String? descriptionDecor,
    int? price,
    int? quantity,
    int? status,
  }) {
    return PlantModel(
      id: id ?? this.id,
      idPlantType: idPlantType ?? this.idPlantType,
      plantType: plantType ?? this.plantType,
      name: name ?? this.name,
      image: image ?? this.image,
      descriptionDecor: descriptionDecor ?? this.descriptionDecor,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idPlantType': idPlantType,
      'plantType': plantType?.toMap(),
      'name': name,
      'image': image,
      'descriptionDecor': descriptionDecor,
      'price': price,
      'quantity': quantity,
      'status': status,
    };
  }

  factory PlantModel.fromMap(Map<String, dynamic> map) {
    return PlantModel(
      id: map['id'] != null ? map['id'] as int : null,
      idPlantType: map['idPlantType'] != null ? map['idPlantType'] as int : null,
      plantType: map['plantType'] != null ? PlantTypeModel.fromMap(map['plantType'] as Map<String, dynamic>) : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      descriptionDecor: map['descriptionDecor'] != null ? map['descriptionDecor'] as String : null,
      price: map['price'] != null ? map['price'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      status: map['status'] != null ? map['status'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlantModel.fromJson(String source) => PlantModel.fromMap(json.decode(source) as Map<String, dynamic>);

  List<String> listImage() {
    if (image != null && image != "") {
      return image!.split(',');
    } else {
      return [];
    }
  }
}
