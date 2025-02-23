// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:service_plant/service_plant.dart';
import 'package:service_user/service_user.dart';

class SearchCubitState extends Equatable {
  SearchStatus status;
  List<String> listHistoryFind;
  List<PlantModel> listPlants;
  PlantTypeModel? plantTypeModel;
  SearchCubitState({
    required this.status,
    required this.listHistoryFind,
    required this.listPlants,
    this.plantTypeModel,
  });

  SearchCubitState copyWith({
    SearchStatus? status,
    List<String>? listHistoryFind,
    List<PlantModel>? listPlants,
    PlantTypeModel? plantTypeModel,
  }) {
    return SearchCubitState(
      status: status ?? this.status,
      listHistoryFind: listHistoryFind ?? this.listHistoryFind,
      listPlants: listPlants ?? this.listPlants,
      plantTypeModel: plantTypeModel ?? this.plantTypeModel,
    );
  }

  @override
  List<Object?> get props => [status, listHistoryFind, listHistoryFind.length, listPlants, listPlants.length, plantTypeModel];
}

enum SearchStatus { initial, loading, success, error }
