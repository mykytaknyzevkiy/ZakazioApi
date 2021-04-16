class RegionModel {
  final int id;
  final String name;
  final int code;

  RegionModel(this.id, this.name, this.code);

  RegionModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        code = json["code"];
}
