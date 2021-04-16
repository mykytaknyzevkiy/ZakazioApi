class PagedListModel<T> {
  final List<T>? content;
  final int totalPages;
  int number = 0;

  PagedListModel(this.content, this.totalPages);

  PagedListModel.create(this.content, this.totalPages, this.number);

  PagedListModel.fromJson(
      Map<String, dynamic> json, T dataEnc(Map<String, dynamic> json))
      : content =
            (json["content"] as List).map((item) => dataEnc(item)).toList(),
        totalPages = json["totalPages"],
        number = json["number"];
}
