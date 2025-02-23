// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PlantTypeModel {
  final int? id;
  final String? name;
  final String? avatar;
  PlantTypeModel({
    this.id,
    this.name,
    this.avatar,
  });

  PlantTypeModel copyWith({
    int? id,
    String? name,
    String? avatar,
  }) {
    return PlantTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'avatar': avatar,
    };
  }

  factory PlantTypeModel.fromMap(Map<String, dynamic> map) {
    return PlantTypeModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlantTypeModel.fromJson(String source) => PlantTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
