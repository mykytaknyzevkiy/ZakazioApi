class NotificationEnableSettings {
  bool createOrder;
  bool youExecutorOrder;
  bool clientHasExecutor;
  bool clientOrderInWork;

  NotificationEnableSettings(this.clientHasExecutor, this.clientOrderInWork,
      this.createOrder, this.youExecutorOrder);

  NotificationEnableSettings.fromJson(Map<String, dynamic> json)
      : createOrder = json["createOrder"],
        youExecutorOrder = json["youExecutorOrder"],
        clientHasExecutor = json["clientHasExecutor"],
        clientOrderInWork = json["clientOrderInWork"];

  Map<String, dynamic> toJson() => {
    "createOrder": createOrder,
    "youExecutorOrder": youExecutorOrder,
    "clientHasExecutor": clientHasExecutor,
    "clientOrderInWork": clientOrderInWork
  };
}
