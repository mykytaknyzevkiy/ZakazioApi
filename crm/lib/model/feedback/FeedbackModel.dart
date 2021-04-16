import 'package:zakazy_crm_v2/factor/UserFactor.dart';
import 'package:zakazy_crm_v2/model/order/OrderModel.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';

class FeedbackModel {
  final int id;
  final String comment;
  final int stars;
  final String creationDateTime;
  final UserInfoModel user;
  final OrderModel order;

  FeedbackModel(
      this.id,
      this.comment,
      this.stars,
      this.creationDateTime,
      this.user,
      this.order);

  FeedbackModel.fromJson(Map<String, dynamic> json) :
      id = json["id"],
      comment = json["comment"],
      stars = json["stars"],
      creationDateTime = json["creationDateTime"],
      user = UserFactor().build(json["user"]),
      order = OrderModel.fromJson(json["order"]);
}