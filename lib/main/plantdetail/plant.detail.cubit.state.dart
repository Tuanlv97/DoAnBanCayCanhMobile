// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:service_plant/service_plant.dart';
import 'package:service_user/service_user.dart';

class PlantDetailCubitState extends Equatable {
  final PlantDetailStatus status;
  final PlantModel plantModel;
  final int numberBuy;
  const PlantDetailCubitState({
    required this.status,
    required this.plantModel,
    required this.numberBuy,
  });

  PlantDetailCubitState copyWith({
    PlantDetailStatus? status,
    PlantModel? plantModel,
    int? numberBuy,
  }) {
    return PlantDetailCubitState(
      status: status ?? this.status,
      plantModel: plantModel ?? this.plantModel,
      numberBuy: numberBuy ?? this.numberBuy,
    );
  }

  @override
  List<Object> get props => [status, plantModel, numberBuy, plantModel];
}

enum PlantDetailStatus { initial, loading, success, error }
