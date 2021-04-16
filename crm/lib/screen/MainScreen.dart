import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/dashboard/NewDashboardScreen.dart';
import 'package:zakazy_crm_v2/screen/order/AllOrderScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainState();
}

class MainState extends State<MainScreen> {
  final _userRepository = UserRepository.instance();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _userRepository.myUserLiveData,
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          final userInfo = snapShot.requireData as UserInfoModel;
          if (userInfo.roleInfo() == RoleType.EXECUTOR)
            return AllOrderScreen();
          else
            return NewDashboardScreen();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
