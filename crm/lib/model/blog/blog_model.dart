import 'package:intl/intl.dart';

class BlogModel {
  final int id;

  final String title;

  final String content;

  final String wallpaper;

  final String creationDateTime;

  BlogModel(
      this.id, this.title, this.content, this.wallpaper, this.creationDateTime);

  BlogModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        content = json["content"],
        wallpaper = json["wallpaper"],
        creationDateTime = json["creationDateTime"];

  String dateStr() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

    return formatter.format(DateTime.parse(creationDateTime));
  }
}
