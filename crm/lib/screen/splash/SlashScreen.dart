import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/splash/SplashBanner.dart';
import 'package:zakazy_crm_v2/screens.dart';

class SlashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SlashScreen> {
  final _userRepository = UserRepository.instance();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SplashBanner(),
      );

  _loadData() async {
    //await Future.delayed(Duration(seconds: 1));

    //final isLogin = await _userRepository.initUser();

    /*if (isLogin) {
      ZakazioNavigator.push(context, "user/profile/my");
    } else {
      ZakazioNavigator.push(context, "login");
    }*/
  }
}
