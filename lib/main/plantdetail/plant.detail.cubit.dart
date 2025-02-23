import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_plant/service_plant.dart';

import '../../repository/repository_plant.dart';
import 'plant.detail.cubit.state.dart';

class PlantDetailCubit extends Cubit<PlantDetailCubitState> {
  final PlantRepository plantRepository;
  final PlantModel plantModel;

  PlantDetailCubit({required this.plantRepository, required this.plantModel})
      : super(PlantDetailCubitState(status: PlantDetailStatus.initial, plantModel: plantModel, numberBuy: 0)) {
    getData();
  }
  getData() async {
    print(plantModel.toMap());
  }

  void removeNumberBuy() {
    if (state.numberBuy > 0) {
      emit(state.copyWith(numberBuy: state.numberBuy - 1));
    }
  }

  void addNumberBuy() {
    emit(state.copyWith(numberBuy: state.numberBuy + 1));
  }

  void resetNumberBuy() {
    emit(state.copyWith(numberBuy: 0));
  }
}
