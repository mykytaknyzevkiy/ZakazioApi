import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileViewModel.dart';
import 'package:zakazy_crm_v2/screen/profile/my/MyProfileViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

class UserDataVertificator extends StatelessWidget {
  final UserInfoModel user;
  final UserProfileViewModel viewModel;

  final _userRepository = UserRepository.instance();

  UserDataVertificator({required this.user, required this.viewModel});

  @override
  Widget build(BuildContext context) => SizedBox(
      width: double.infinity,
      child: Padding(
          padding: EdgeInsets.all(24),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            runAlignment: WrapAlignment.center,
            runSpacing: 15,
            children: [
              //verticator(
              //    Icons.phone,
              //    "Телефон",
              //    user.phoneActive,
              //    (viewModel is MyProfileViewModel)
              //        ? (viewModel as MyProfileViewModel).onPhoneVerificate
              //        : null,
              //    false),
              verticator(
                  Icons.mail,
                  "Почта",
                  user.emailActive,
                  (viewModel is MyProfileViewModel)
                      ? (viewModel as MyProfileViewModel).onEmailVertificate
                      : null,
                  false),
              (viewModel.userInfo.value!.roleInfo() == RoleType.CLIENT)
                  ? Container()
                  : verticator(
                      Icons.ad_units_sharp,
                      "Паспорт",
                      user.passportActive,
                      (viewModel is MyProfileViewModel)
                          ? (viewModel as MyProfileViewModel)
                              .onPasportVerificate
                          : null,
                      user.passportInProgress)
            ],
          )));

  verticator(IconData icon, String title, bool isVertify,
          VoidCallback? onVeriticate, bool isProcess) =>
      Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 85,
              height: 85,
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: isProcess == true
                      ? Colors.orange
                      : isVertify
                          ? Colors.greenAccent
                          : Colors.redAccent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 30, color: Colors.white),
                  Divider(
                    height: 5,
                    color: Colors.transparent,
                  ),
                  Text(title, style: TextStyle(color: Colors.white))
                ],
              )),
          (!isVertify &&
                  isProcess != true &&
                  _userRepository.myUserLiveData.value?.id == user.id)
              ? SmallFreeButton(
                  title: "Подтвердить",
                  onPressed: onVeriticate != null ? onVeriticate : () => {},
                  isEnable: true)
              : Container(
                  width: 10,
                )
        ],
      );
}
