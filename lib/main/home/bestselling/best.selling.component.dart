import 'package:app_mobile/confing.dart';
import 'package:app_mobile/constants/button.not.click.multi.dart';
import 'package:app_mobile/constants/format.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:service_plant/service_plant.dart';

import '../../../constants/plant.item.dart';
import '../../../main.router.constant.dart';
import '../../favorite/favorite.cubit.dart';
import '../component/data.page.model.dart';

class BestSellingComponent extends StatelessWidget {
  final List<PlantModel> listPlant;

  const BestSellingComponent({super.key, required this.listPlant});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Sản phẩm bán chạy",
                style: TextStyle(fontSize: 20, color: Color(0xFF325A3E), fontWeight: FontWeight.w700),
              ),
              ButtonNotClickMulti(
                  onTap: () {
                    context.push(MainRouterPath.routerPlantPage, extra: DataPageModel(pageName: 'Sản phẩm bán chạy', listData: listPlant));
                  },
                  child: const Text(
                    "Xem tất cả >",
                    style: TextStyle(fontSize: 12, color: Color(0xFF999898)),
                  )),
            ],
          ),
          SizedBox(
            height: 206,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: listPlant.length,
              itemBuilder: (context, index) {
                var plant = listPlant[index];
                return PlantItem(plant: plant);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 20,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
