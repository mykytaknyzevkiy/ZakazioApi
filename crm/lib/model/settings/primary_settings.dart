class PrimarySettings {
  final int executorMaxOrder;
  int orderSumOutPercent;
  int orderPartnerPercent;
  int executorPartnerPercent;

  PrimarySettings(this.executorMaxOrder, this.orderSumOutPercent,
      this.orderPartnerPercent, this.executorPartnerPercent);

  PrimarySettings.fromJson(Map<String, dynamic> json)
      : executorMaxOrder = json["executorMaxOrder"],
        orderSumOutPercent = json["orderSumOutPercent"],
        orderPartnerPercent = json["orderPartnerPercent"],
        executorPartnerPercent = json["executorPartnerPercent"];

  Map<String, dynamic> toJson() => {
    "executorMaxOrder": executorMaxOrder,
    "orderSumOutPercent": orderSumOutPercent,
    "orderPartnerPercent": orderPartnerPercent,
    "executorPartnerPercent": executorPartnerPercent
  };
}
