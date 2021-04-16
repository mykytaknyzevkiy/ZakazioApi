class PortfolioModel {
  final int id;
  final String wallpaper;
  final String label;
  final String description;
  final List<String> imageSlides;

  PortfolioModel(
      this.id, this.wallpaper, this.label, this.description, this.imageSlides);

  static PortfolioModel fromJson(Map<String, dynamic> json) => PortfolioModel(
      json["id"],
      json["wallpaper"],
      json["label"],
      json["description"],
      (json["imageSlides"] as List).map((e) => e.toString()).toList());
}
