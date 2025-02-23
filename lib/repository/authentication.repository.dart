import 'package:rxdart/rxdart.dart';
import 'package:service_plant/service_plant.dart';
import 'package:service_user/service_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'repository_user.dart';

class AuthenticationRepository {
  final ServiceUser serviceUser = ServiceUser();

  AuthenticationRepository({
    UserRepository? userRepository,
  }) : _userRepository = userRepository ?? UserRepository();

  final UserRepository _userRepository;
  final userForAuthenChange = BehaviorSubject<UserModel?>();
  bool isRegister = false;
  String? tokenFirebase;
  Stream<UserModel?> get userForAuthen {
    return userForAuthenChange.stream;
  }

  Stream<UserModel?> get user {
    return _userRepository.user;
  }

  UserModel? get currentUser {
    return _userRepository.getUser();
  }

  UserModel updateUer(UserModel userModel) {
    userChange(userModel);
    _userRepository.updateUser(userModel);
    return userModel;
  }

  userChange(UserModel userModel) {
    _userRepository.updateUser(userModel);
  }

  userRepo(UserModel userModel) {
    userForAuthenChange.add(userModel);
  }

  Future<void> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    requestEmptyUser();
  }

  void requestEmptyUser() {
    userForAuthenChange.add(null);
    _userRepository.updateUser(null);
  }

  void updateUserFromTutorial() {
    final user = _userRepository.getUser();
    userForAuthenChange.add(user);
  }

  Future<UserModel?> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _userRepository.register(email: email, password: password, name: name);
    if (response != null) {
      await prefs.setString("email", email);
      await prefs.setString("pass", password);
      userRepo(response);
      userChange(response);
    }
    return response;
  }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _userRepository.login(email: email, password: password);
    if (response != null) {
      await prefs.setString("email", email);
      await prefs.setString("pass", password);
      updateUer(response);
      userRepo(response);
    } else {
      requestEmptyUser();
    }
    return response;
  }

  Future<List<PlantModel>> getFavorite() async {
    List<PlantModel> listFavorite = [];
    var response = await serviceUser.getFavorite(userId: currentUser?.id ?? 0);
    for (var element in response) {
      listFavorite.add(PlantModel.fromMap(element['plant']));
    }
    return listFavorite;
  }

  Future<bool> addFavorite({required int idPlant}) async {
    return await serviceUser.addFavorite(userId: currentUser?.id ?? 0, idPlant: idPlant);
  }

  Future<bool> deleteFavorite({required int idPlant}) async {
    return await serviceUser.deleteFavorite(
      idPlant: idPlant,
      userId: currentUser?.id ?? 0,
    );
  }

  Future<bool> updateUserDatabase(UserModel userModel) async {
    return await serviceUser.updateUserDatabase(userModel);
  }

  Future<bool> changePassword({required String password, required int idUser}) async {
    return await serviceUser.changePassword(password: password, idUser:idUser);
  }
}
