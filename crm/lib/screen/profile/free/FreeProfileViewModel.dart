import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/model/transaction/TransactionModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/rest/PaymentRest.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileViewModel.dart';

class FreeProfileViewModel extends UserProfileViewModel<UserInfoModel> {
  FreeProfileViewModel(int userID) : super(userID);

  @override
  close() {
    return super.close();
  }

}