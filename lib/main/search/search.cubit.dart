import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_plant/service_plant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../repository/repository_plant.dart';
import 'search.cubit.state.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  final PlantRepository plantRepository;
  final TextEditingController searchController = TextEditingController();
  PlantTypeModel? plantTypeModel;
  SearchCubit({required this.plantRepository, this.plantTypeModel})
      : super(SearchCubitState(status: SearchStatus.initial, listHistoryFind: [], listPlants: [], plantTypeModel: plantTypeModel)) {
    getData();
  }
  getData() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var listHistory = prefs.getStringList("history") ?? [];
    List<PlantModel> listData =
        await plantRepository.getListPlant(name: searchController.text != "" ? searchController.text : null, idPlantType: plantTypeModel?.id);
    emit(state.copyWith(status: SearchStatus.success, listHistoryFind: listHistory, listPlants: listData));
  }

  findPlant() async {
    addHistory(searchController.text);
    await getData();
  }

  findPlantHistory(String findHistory) async {
    searchController.text = findHistory;
  }

  addHistory(String historyNew) async {
    emit(state.copyWith(status: SearchStatus.initial));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (historyNew.isNotEmpty) {
      if (state.listHistoryFind.contains(historyNew)) {
      } else {
        state.listHistoryFind.insert(0, historyNew);
        prefs.setStringList("history", state.listHistoryFind);
      }
    }

    emit(state.copyWith(status: SearchStatus.success, listHistoryFind: state.listHistoryFind));
  }

  removeHistory(String historyNew) async {
    emit(state.copyWith(status: SearchStatus.initial));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state.listHistoryFind.remove(historyNew);
    prefs.setStringList("history", state.listHistoryFind);
    emit(state.copyWith(status: SearchStatus.success, listHistoryFind: state.listHistoryFind));
  }
}
