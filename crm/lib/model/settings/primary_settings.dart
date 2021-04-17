class PrimarySettings {
  final int executorMaxOrder;
  int orderSumOutPercent;
  int orderPartnerPercent;
  int executorPartnerPercent;
  int executorWaitingTimeToStart;

  PrimarySettings(this.executorMaxOrder, this.orderSumOutPercent,
      this.orderPartnerPercent, this.executorPartnerPercent, this.executorWaitingTimeToStart);

  PrimarySettings.fromJson(Map<String, dynamic> json)
      : executorMaxOrder = json["executorMaxOrder"],
        orderSumOutPercent = json["orderSumOutPercent"],
        orderPartnerPercent = json["orderPartnerPercent"],
        executorPartnerPercent = json["executorPartnerPercent"],
        executorWaitingTimeToStart = json["executorWaitingTimeToStart"];

  Map<String, dynamic> toJson() => {
    "executorMaxOrder": executorMaxOrder,
    "orderSumOutPercent": orderSumOutPercent,
    "orderPartnerPercent": orderPartnerPercent,
    "executorPartnerPercent": executorPartnerPercent,
    "executorWaitingTimeToStart": executorWaitingTimeToStart
  };
}
