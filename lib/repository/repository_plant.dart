import 'package:rxdart/rxdart.dart';
import 'package:service_plant/service_plant.dart';

class PlantRepository {
  final ServicePlant servicePlant = ServicePlant();
  Future<PlantDetailModel> getPlantDetail({required int idPlant}) async {
    return PlantDetailModel(
        id: idPlant,
        name: "Cây xương rồng",
        point: 30000,
        count: 50,
        image: [
          "xuong-rong-1.jpeg",
          "xuong-rong-2.jpeg",
          "xuong-rong-3.jpeg",
          "xuong-rong-4.jpeg",
        ],
        description:
            "Một trong những xu thế decor quán, shop, cửa hàng…đang rất được ưa chuộng chính là trồng cây xương rồng trụ. Với thân cây to, hình dáng đơn giản giúp không gian và vật thể nổi bật hơn. Cây ít phải chăm sóc, trồng ở điều kiện nắng có thể ra hoa trắng, mùi thơm dịu.");
  }

  cart() {}

  Future<List<PlantTypeModel>> getListPlantType() async {
    return await servicePlant.getListPlantType();
  }

  Future<List<PlantModel>> getListPlant({
    String? name,
    int? idPlantType,
  }) async {
    return await servicePlant.getListPlant(name: name, idPlantType: idPlantType);
  }

  Future<List<PlantModel>> getListBestSelling() async {
    return await servicePlant.getListBestSelling();
  }

  Future<List<CartItem>> getListCart({required int idUser}) async {
    return await servicePlant.getListCart(idUser: idUser);
  }

  Future<CartItem> addCart({required int idPlant, required int number, required int idUser}) async {
    return await servicePlant.addCart(idPlant: idPlant, number: number, idUser: idUser);
  }

  update({required CartItem cart}) async {
    await servicePlant.update(cart: cart);
  }

  dateteCart({required int idCart}) {
    servicePlant.dateteCart(idCart: idCart);
  }
}
