import 'package:app_mobile/repository/repository_plant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_plant/service_plant.dart';
import 'home.cubit.state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  final PlantRepository plantRepository;
  HomeCubit({required this.plantRepository}) : super(const HomeCubitState(status: Status.initial, listSuggest: [], listBestSelling: [])) {
    getData();
  }
  getData() async {
    emit(state.copyWith(status: Status.loading));
    List<PlantModel> listSuggest = await plantRepository.getListPlant();
    List<PlantModel> listBestSelling = await plantRepository.getListBestSelling();
    emit(state.copyWith(status: Status.success, listSuggest: listSuggest, listBestSelling: listBestSelling));
  }
}
