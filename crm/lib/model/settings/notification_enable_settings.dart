class NotificationEnableSettings {
  bool createOrder;
  bool onExecutorInOrder;
  bool onOrderStatus;

  NotificationEnableSettings(
      this.onOrderStatus,
      this.createOrder,
      this.onExecutorInOrder);

  NotificationEnableSettings.fromJson(Map<String, dynamic> json)
      : createOrder = json["createOrder"],
        onExecutorInOrder = json["onExecutorInOrder"],
        onOrderStatus = json["onOrderStatus"];

  Map<String, dynamic> toJson() => {
    "createOrder": createOrder,
    "onExecutorInOrder": onExecutorInOrder,
    "onOrderStatus": onOrderStatus
  };
}
