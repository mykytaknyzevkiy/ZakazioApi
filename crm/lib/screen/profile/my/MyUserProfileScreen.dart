import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/profile/NewUserProfileScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileViewModel.dart';
import 'package:zakazy_crm_v2/screen/profile/my/MyProfileViewModel.dart';
import 'package:zakazy_crm_v2/screen/profile/my/active/ActiveMyEmailScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/my/active/ActiveMyPhoneScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/my/active/ActivePasportScreen.dart';

class MyUserProfileScreen extends StatefulWidget {

  MyUserProfileScreen();

  @override
  State<StatefulWidget> createState() => _MyUserProfileScreenState();
}

class _MyUserProfileScreenState extends NewUserProfileScreen<MyUserProfileScreen,
    UserInfoModel, MyProfileViewModel> {

  @override
  List<Widget> exChilds() => [];

  @override
  Widget findExRightDialog(ToEditData data) {
    if (data.method == ToEditEnum.VERTIFY_PHONE) {
      return ActiveMyPhoneScreen(data.data);
    } else if (data.method == ToEditEnum.VERTIFY_EMAIL) {
      return ActiveMyEmailScreen(data.data);
    } else if (data.method == ToEditEnum.VERTIFY_PASPORT) {
      return ActivePasportScreen();
    } else
      return Container();
  }

  @override
  MyProfileViewModel viewModelInstancer() => MyProfileViewModel();
}
