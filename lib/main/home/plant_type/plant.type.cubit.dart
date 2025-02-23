import 'package:app_mobile/repository/repository_plant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_plant/service_plant.dart';
import '../../../constants/list.load.state.dart';

class PlantTypeCubit extends Cubit<ListLoadState<PlantTypeModel>> {
  final PlantRepository plantRepository;
  final ScrollController scrollController = ScrollController();

  PlantTypeCubit({required this.plantRepository}) : super(const ListLoadState()) {
    getData();
    scrollController.addListener(_onScroll);
  }
  getData() async{
    emit(state.copyWith(status: ListLoadStatus.loading));
    List<PlantTypeModel> listPlantType = await plantRepository.getListPlantType();
    emit(state.copyWith(status: ListLoadStatus.loadmore, list: listPlantType));
  }

  Future<void> _onScroll() async {}
}
