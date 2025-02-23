import 'package:app_mobile/confing.dart';
import 'package:app_mobile/constants/button.not.click.multi.dart';
import 'package:app_mobile/main.router.constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:service_plant/service_plant.dart';

import '../../../constants/list.load.state.dart';
import 'plant.type.cubit.dart';

class PlantTypeComponent extends StatelessWidget {
  const PlantTypeComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantTypeCubit, ListLoadState<PlantTypeModel>>(
      builder: (context, state) {
        return SizedBox(
          height: 110,
          child: ListView.separated(
            controller: context.read<PlantTypeCubit>().scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: state.list.length,
            itemBuilder: (context, index) {
              return ButtonNotClickMulti(
                onTap: () {
                  context.push(MainRouterPath.routerSearch, extra: state.list[index]);
                },
                child: Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      margin: const EdgeInsets.only(bottom: 12, left: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: CachedNetworkImage(
                        imageUrl: "$baseUrlImage${state.list[index].avatar}",
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5), image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                color: Colors.grey),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                        width: 56,
                        child: Text(
                          state.list[index].name ?? "",
                          style: const TextStyle(fontSize: 9),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                        )),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 10,
              );
            },
          ),
        );
      },
    );
  }
}
