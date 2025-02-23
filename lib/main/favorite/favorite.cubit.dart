import 'dart:async';

import 'package:app_mobile/repository/repository_plant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:service_plant/src/model/plant.model.dart';
import 'package:service_user/service_user.dart';

import '../../repository/authentication.repository.dart';

class FavoriteCubit extends Cubit<FavoriteCubitState> {
  final AuthenticationRepository authenticationRepository;
  final PlantRepository plantRepository;

  FavoriteCubit(this.authenticationRepository, this.plantRepository)
      : super(FavoriteCubitState(status: FavoriteStatus.initial, listFavorite: [], listFavoriteModel: [])) ;
  getData() async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    List<PlantModel> listF = await authenticationRepository.getFavorite();
    List<int> listId = List.generate(listF.length, (index) => listF[index].id ?? 0);
    emit(state.copyWith(status: FavoriteStatus.success, listFavorite: listId, listFavoriteModel: listF));
  }

  cleanData() {
    emit(state.copyWith(status: FavoriteStatus.initial, listFavorite: [], listFavoriteModel: []));
  }

  void handleFavorite({required PlantModel plant}) {
    if (plant.id != null) {
      emit(state.copyWith(status: FavoriteStatus.loading));
      if (state.listFavorite.contains(plant.id)) {
        var index = 0;
        for (var i = 0; i < state.listFavorite.length; i++) {
          if (state.listFavorite[i] == plant.id!) {
            index = i;
          }
        }
        state.listFavorite.removeAt(index);
        state.listFavoriteModel.removeAt(index);
        removeFavorite(plant);
      } else {
        state.listFavorite.add(plant.id ?? 0);
        state.listFavoriteModel.add(plant);
        addFavorite(plant);
      }
      emit(state.copyWith(status: FavoriteStatus.success, listFavorite: state.listFavorite, listFavoriteModel: state.listFavoriteModel));
    }
  }

  addFavorite(PlantModel plant) {
    authenticationRepository.addFavorite(idPlant: plant.id ?? 0);
  }

  removeFavorite(PlantModel plant) {
    authenticationRepository.deleteFavorite(idPlant: plant.id ?? 0);
  }
}

class FavoriteCubitState extends Equatable {
  final FavoriteStatus status;
  List<int> listFavorite;
  List<PlantModel> listFavoriteModel;

  FavoriteCubitState({
    required this.status,
    required this.listFavorite,
    required this.listFavoriteModel,
  });

  FavoriteCubitState copyWith({
    FavoriteStatus? status,
    List<int>? listFavorite,
    List<PlantModel>? listFavoriteModel,
  }) {
    return FavoriteCubitState(
      status: status ?? this.status,
      listFavorite: listFavorite ?? this.listFavorite,
      listFavoriteModel: listFavoriteModel ?? this.listFavoriteModel,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listFavorite,
        listFavorite.length,
        listFavoriteModel,
        listFavoriteModel.length,
      ];
}

enum FavoriteStatus { initial, loading, success, error }
