// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PlantDetailModel {
  int? id;
  String? name;
  int? point;
  int? count;
  String? description;
  List<String> image;
  PlantDetailModel({
    this.id,
    this.name,
    this.point,
    this.count,
    this.description,
    required this.image,
  });

  PlantDetailModel copyWith({
    int? id,
    String? name,
    int? point,
    int? count,
    String? description,
    List<String>? image,
  }) {
    return PlantDetailModel(
      id: id ?? this.id,
      name: name ?? this.name,
      point: point ?? this.point,
      count: count ?? this.count,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'point': point,
      'count': count,
      'description': description,
      'image': image,
    };
  }

  factory PlantDetailModel.fromMap(Map<String, dynamic> map) {
    return PlantDetailModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      point: map['point'] != null ? map['point'] as int : null,
      count: map['count'] != null ? map['count'] as int : null,
      description: map['description'] != null ? map['description'] as String : null,
      image: List<String>.from((map['image'] ?? const <String>[]) as List<String>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlantDetailModel.fromJson(String source) => PlantDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
