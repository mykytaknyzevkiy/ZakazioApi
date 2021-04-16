class CloudPayment3dsModel {
  final int transactionId;
  final String paReq;
  final String acsUrl;

  CloudPayment3dsModel(this.transactionId, this.paReq, this.acsUrl);

  CloudPayment3dsModel.fromJson(Map<String, dynamic> json) :
        transactionId = json["transactionId"],
        paReq = json["paReq"],
        acsUrl = json["acsUrl"];

}