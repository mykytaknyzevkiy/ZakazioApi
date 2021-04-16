class UserOrderInfoModel {
  final bool enable;
  final _UserOrderInfoCountModel count;

  UserOrderInfoModel(this.enable, this.count);

  UserOrderInfoModel.fromJson(Map<String, dynamic> json)
      : enable = json["enable"],
        count = _UserOrderInfoCountModel.fromJson(json["count"]);

  UserOrderInfoModel.empty() :
      enable = false,
      count = _UserOrderInfoCountModel(
        0,
        0,
        0,
        0
      );
}

class _UserOrderInfoCountModel {
  final int open;
  final int close;
  final int max;
  final int declined;

  _UserOrderInfoCountModel(this.open, this.close, this.max, this.declined);

  _UserOrderInfoCountModel.fromJson(Map<String, dynamic> json)
      : open = json["open"],
        close = json["close"],
        max = json["max"],
        declined = json["declined"];
}
