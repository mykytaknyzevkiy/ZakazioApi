import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

class SmsAdminScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SmsAdminState();
}

class SmsAdminState extends HomeScreen<SmsAdminScreen, SmsAdminVM> {

  @override
  Widget body() {
    final viewID = "sms_admin";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        viewID,
            (int id) => html.IFrameElement()
          ..src = "https://smsadmin.zakazy.online/"
          ..style.border = 'none');

    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 200,
          child: HtmlElementView(
            viewType: viewID,
          )
        ),
      ),
    );
  }

  @override
  Widget top() => createTitleView("Смс админ");

  @override
SmsAdminVM viewModelInstancer() => SmsAdminVM();

}

class SmsAdminVM extends ZakazyViewModel {
  @override
  close() {
  }
}