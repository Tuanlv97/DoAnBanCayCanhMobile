import 'package:service_base/service_base.dart';
import 'package:service_plant/service_plant.dart';

class ServicePlant extends BaseService {
  Future<List<PlantTypeModel>> getListPlantType() async {
    List<PlantTypeModel> listData = [];
    try {
      await get(
        route: "plant-type/get/page?page=0&size=100000&sort=id,desc",
        timeout: 50,
        onConvert: (data) {
          if (data?['content'] != null && data?['content'] is List) {
            for (var element in data!['content']) {
              listData.add(PlantTypeModel.fromMap(element));
            }
          }
        },
      );
    } catch (e) {
      print("Loi: $e");
    }
    return listData;
  }

  Future<List<PlantModel>> getListPlant({
    String? name,
    int? idPlantType,
  }) async {
    List<PlantModel> listData = [];
    String filtterName = "";
    String filtterplantId = "";
    if (name != null) {
      filtterName = "&filter=name~'*$name*'";
    }
    if (idPlantType != null) {
      filtterplantId = "&filter=idPlantType: $idPlantType";
    }
    try {
      await get(
        route: "plant/get/page?page=0&size=100000$filtterName$filtterplantId&filter=status:1&sort=id,desc",
        timeout: 50,
        onConvert: (data) {
          if (data?['content'] != null && data?['content'] is List) {
            for (var element in data!['content']) {
              listData.add(PlantModel.fromMap(element));
            }
          }
        },
      );
    } catch (e) {
      print("Loi: $e");
    }
    return listData;
  }

  Future<List<PlantModel>> getListBestSelling() async {
    List<PlantModel> listData = [];
    try {
      await get(
        route: "plant/get/page?page=0&size=20&sort=sold,desc",
        timeout: 50,
        onConvert: (data) {
          if (data?['content'] != null && data?['content'] is List) {
            for (var element in data!['content']) {
              listData.add(PlantModel.fromMap(element));
            }
          }
        },
      );
    } catch (e) {
      print("Loi: $e");
    }
    return listData;
  }

  Future<List<CartItem>> getListCart({required int idUser}) async {
    List<CartItem> listData = [];
    try {
      await get(
        route: "cart/get/page?filter=idUser:$idUser",
        timeout: 50,
        onConvert: (data) {
          if (data?['content'] != null && data?['content'] is List) {
            for (var element in data!['content']) {
              listData.add(CartItem.fromMap(element));
            }
          }
        },
      );
    } catch (e) {
      print("Loi: $e");
    }
    return listData;
  }

  Future<CartItem> addCart({required int idPlant, required int number, required int idUser}) async {
    Map<String, dynamic> requestBodyLogin = {"idPlant": idPlant, "idUser": idUser, "number": number};
    CartItem cartItem = CartItem();
    try {
      await post(
        api: "cart/post",
        body: requestBodyLogin,
        timeout: 50,
        onConvert: (data) {
          cartItem = CartItem.fromMap(data ?? {});
        },
      );
    } catch (e) {
      print("Loi: $e");
    }
    return cartItem;
  }

  update({required CartItem cart}) async {
    try {
      await put(
        api: "cart/put/${cart.id}",
        body: cart.toMap(),
        timeout: 50,
        onConvert: (data) {},
      );
    } catch (e) {
      print("Loi: $e");
    }
  }

  void dateteCart({required int idCart}) async {
    try {
      await delete(
        api: "cart/del/$idCart",
        timeout: 50,
      );
    } catch (e) {}
  }
}
