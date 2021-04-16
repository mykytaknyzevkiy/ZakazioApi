import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/profile/NewUserProfileScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileViewModel.dart';
import 'package:zakazy_crm_v2/screen/profile/free/FreeProfileViewModel.dart';
import 'package:zakazy_crm_v2/widget/payment/UserTransactionList.dart';

class FreeProfileScreen extends StatefulWidget {
  int userID = 0;

  FreeProfileScreen({required this.userID});

  @override
  State<StatefulWidget> createState() => _FreeProfileScreenState(userID);
}

class _FreeProfileScreenState extends NewUserProfileScreen<FreeProfileScreen,
    UserInfoModel, FreeProfileViewModel> {
  final int userID;

  _FreeProfileScreenState(this.userID);

  @override
  void initState() {
    viewModel().loadTransaction(0);
    super.initState();
  }

  @override
  List<Widget> exChilds() => [
    ([RoleType.ADMIN, RoleType.SUPER_ADMIN].contains(UserRepository.instance().myUserLiveData.value!.roleInfo()) && [RoleType.PARTNER, RoleType.EXECUTOR].contains(viewModel().userInfo.value.roleInfo()))
    ? SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Транзакции",
                  style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Divider(
                color: Colors.transparent,
                height: 40,
              ),
              UserTransactionList(
                  data: viewModel().userTransactions,
                  onLoad: viewModel().loadTransaction
              )
            ],
          ),
        ),
      ),
    )
    : Container()
  ];

  @override
  Widget findExRightDialog(ToEditData data) {
    return Container();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  FreeProfileViewModel viewModelInstancer() => FreeProfileViewModel(userID);
}
