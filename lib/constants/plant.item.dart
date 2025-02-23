import 'package:app_mobile/main.router.constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:service_plant/service_plant.dart';

import '../confing.dart';
import '../main/favorite/favorite.cubit.dart';
import 'button.not.click.multi.dart';
import 'format.dart';

class PlantItem extends StatelessWidget {
  final double? width;
  final PlantModel plant;
  const PlantItem({super.key, required this.plant, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: Key("plant:${plant.id}"),
      width: width ?? 175,
      height: 206,
      child: ButtonNotClickMulti(
        onTap: () {
          context.push(MainRouterPath.routerPlantDetailPage, extra: plant);
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1, color: Color(0xFFD8D8D8)),
                          right: BorderSide(width: 1, color: Color(0xFFD8D8D8)),
                          top: BorderSide(width: 1, color: Color(0xFFD8D8D8)),
                        ),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                    width: 175,
                    height: 146,
                    child: (plant.listImage().isNotEmpty && plant.listImage().first != "")
                        ? CachedNetworkImage(
                            imageUrl: "$baseUrlImage${plant.listImage().first}",
                            imageBuilder: (context, imageProvider) => Container(
                              width: 175,
                              height: 146,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              width: 175,
                              height: 146,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                image: DecorationImage(image: AssetImage("assets/plant.png"), fit: BoxFit.cover),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 175,
                              height: 146,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                image: DecorationImage(image: AssetImage("assets/plant.png"), fit: BoxFit.cover),
                              ),
                            ),
                          )
                        : Container(
                            width: 175,
                            height: 146,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                              image: DecorationImage(image: AssetImage("assets/plant.png"), fit: BoxFit.cover),
                            ),
                          ),
                  ),
                  Container(
                    width: 175,
                    height: 60,
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                        border: Border(
                          left: BorderSide(width: 1, color: Color(0xFFD8D8D8)),
                          right: BorderSide(width: 1, color: Color(0xFFD8D8D8)),
                          bottom: BorderSide(width: 1, color: Color(0xFFD8D8D8)),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plant.name ?? "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 14, color: Color(0xFF34493A), fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "${formatNumber(int.tryParse(plant.price.toString()) ?? 0)} VNĐ",
                          style: const TextStyle(fontSize: 14, color: Color(0xFFDF0000)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8, right: 8),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: BlocBuilder<FavoriteCubit, FavoriteCubitState>(
                      builder: (context, state) {
                        return ButtonNotClickMulti(
                          onTap: () {
                            context.read<FavoriteCubit>().handleFavorite(plant: plant);
                          },
                          child: Center(
                            child: Icon(
                              Icons.favorite,
                              size: 20,
                              color: state.listFavorite.contains(plant.id ?? 0) ? const Color(0xFFDF0505) : Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
