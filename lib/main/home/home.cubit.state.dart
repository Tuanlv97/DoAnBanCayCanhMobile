// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:service_plant/service_plant.dart';

class HomeCubitState extends Equatable {
  final Status status;
  final List<PlantModel> listSuggest;
  final List<PlantModel> listBestSelling;

  const HomeCubitState({
    required this.status,
    required this.listSuggest,
    required this.listBestSelling,
  });

  HomeCubitState copyWith({
    Status? status,
    int? pageNumber,
    List<PlantModel>? listSuggest,
    List<PlantModel>? listBestSelling,
  }) {
    return HomeCubitState(
      status: status ?? this.status,
      listSuggest: listSuggest ?? this.listSuggest,
      listBestSelling: listBestSelling ?? this.listSuggest,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listSuggest,
        listSuggest.length,
        listSuggest,
        listSuggest.length,
      ];
}

enum Status { initial, loading, success, error }
