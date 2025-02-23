// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:service_plant/service_plant.dart';

class DataPageModel {
  String pageName;
  List<PlantModel> listData;
  DataPageModel({
    required this.pageName,
    required this.listData,
  });
}
