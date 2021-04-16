import 'package:zakazy_crm_v2/model/address/RegionModel.dart';

class CityModel {
  final int id;
  final String name;
  final int code;
  final RegionModel? region;

  CityModel(this.id, this.name, this.code, this.region);

  CityModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        code = json["code"],
        region = RegionModel.fromJson(json["region"]);
}
