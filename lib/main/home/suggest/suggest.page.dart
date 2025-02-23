import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:service_plant/service_plant.dart';

import '../../../constants/button.not.click.multi.dart';
import '../../../constants/plant.item.dart';

class SuggestPage extends StatelessWidget {
  final List<PlantModel> listPlant;
  final String pageName;
  const SuggestPage({super.key, required this.listPlant, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            const SizedBox(width: 15),
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(color: const Color(0xFFEFEAEA), borderRadius: BorderRadius.circular(20)),
              child: ButtonNotClickMulti(
                onTap: () {
                  context.pop();
                },
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          pageName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF335a3e)),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 10,
              runSpacing: 10,
              children: listPlant.map((e) {
                double width = 0;
                var widthScreen = MediaQuery.of(context).size.width / 2 - 20;
                if (widthScreen > 206) {
                  width = 206;
                } else {
                  width = widthScreen;
                }
                return SizedBox(
                  height: 206,
                  child: PlantItem(
                    width: width,
                    plant: e,
                  ),
                );
              }).toList(),
            ),
          )
          ),
    );
  }
}
