class CategoryModel {
  final int id;
  final String name;
  final bool isActive;
  final String? imageUrl;

  CategoryModel(this.id, this.name, this.isActive, this.imageUrl);

  CategoryModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        isActive = json["isActive"],
        imageUrl = json["imageUrl"];
}
