import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:hexcolor/hexcolor.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/notificattion_service.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/login/LoginScreen.dart';
import 'package:zakazy_crm_v2/screen/splash/SlashScreen.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/home/ZDrawer.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

BuildContext? mainContext;

void main() async {
  setUrlStrategy(ZakazioNavigator.urlController);
  await ZakazioNavigator.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final _userRepository = UserRepository.instance();

  @override
  void initState() {
    _userRepository.initUser();
    super.initState();
  }

  _dataBody() => StreamBuilder(
    stream: _userRepository.myUserLiveData,
    builder: (_, snapShot) {
      if (!snapShot.hasData) {
        return FutureBuilder(
            future: UserRepository.userToken(),
            builder: (_, snappShot) {
              if (snappShot.data == null)
                return LoginScreen();

              return SlashScreen();
            }
        );
      }
      return Row(
        children: [
          ZDrawer(),
          Expanded(
              child: _screen()
          )
        ],
      );
    }
  );

  @override
  Widget build(BuildContext context) {
    mainContext = context;
    return MaterialApp(
      home: Scaffold(
          backgroundColor: HexColor("#fcfcfc"),
          body: _dataBody()
      )
    );
  }

  _notificationBable() => StreamBuilder<NotificationMessage>(
      stream: NotoficationService.onMessage,
      builder: (_, snapShot) {
        if (!snapShot.hasData) return Container();
        return Card(
            elevation: 4,
            color: primaryColor,
            child: SizedBox(
                width: 300,
                height: 150,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapShot.requireData.title,
                            style: TextStyle(fontSize: 18, color: accentColor),
                          ),
                          Divider(height: 15, color: Colors.transparent),
                          Text(
                            snapShot.requireData.message,
                            style: TextStyle(color: accentColor),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 24,
                            color: accentColor,
                          ),
                          onPressed: () =>
                          {NotoficationService.onMessage.add(null)},
                        ),
                      )
                    ],
                  ),
                )));
      });

  _screen() => StreamBuilder<ZakazioScreens>(
      stream: currentScreen,
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          return snapShot.requireData.screen();
        }

        return Center(
          child: CircularProgressIndicator()
        );
      });

}