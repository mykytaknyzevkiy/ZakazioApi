import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';
import 'package:zakazy_crm_v2/widget/HelpMessageBubleWidget.dart';
import 'package:zakazy_crm_v2/widget/home/UserAleartDangeral.dart';

import 'RightScreen.dart';

abstract class HomeScreen<T extends StatefulWidget, VM extends ZakazyViewModel>
    extends State<T> {
  final _provider = ViewModelProvider<VM>();
  final scrollController = ScrollController();

  int selectedIndex() => 0;

  Widget body();

  Widget top();

  Widget rightDialog() {
    return Container();
  }

  Widget rightDialogSized() {
    return Container();
  }

  @override
  void dispose() {
    _provider.close();
    super.dispose();
  }

  Text createTitleView(String title) => Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
      );

  VM viewModelInstancer();

  VM viewModel() {
    return _provider.build(() => viewModelInstancer());
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Stack(
        children: [
          nHome(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: StreamBuilder<HelpMessageBubble>(
                stream: viewModel().helpMessageData,
                builder: (_, snapShot) {
                  if (!snapShot.hasData)
                    return Container();
                  return HelpMessageBubbleWidget(
                      snapShot.requireData.message,
                      snapShot.requireData.buttonData,
                      () => viewModel().helpMessageData.add(null)
                  );
                }
              ),
            ),
          )
        ],
      ),
      Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 350,
            height: MediaQuery.of(context).size.height,
            child: SizedBox(
              width: double.infinity,
              child: rightDialog(),
            ),
          )
      ),
      Align(
        //alignment: Alignment.topRight,
          child: rightDialogSized()
      )
    ],
  );

  userAlertDangeral() => UserAlertDangeral();

  nHome() => Padding(
      padding: EdgeInsets.only(left: 8, top: 0, bottom: 24, right: 8),
      child: Scrollbar(
        controller: scrollController,
        isAlwaysShown: true,
        child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  userAlertDangeral(),
                  Divider(
                    height: 16,
                    color: Colors.transparent,
                  ),
                  top(),
                  Divider(
                    height: 30,
                    color: Colors.transparent,
                  ),
                  body()
                ],
              )
            )
        )
      )
  );
}

class ViewModelProvider<T extends ZakazyViewModel> {
  static final HashSet<ZakazyViewModel> viewModels = HashSet();

  close() {
    ZakazyViewModel? vieM;

    viewModels.forEach((element) {
      if (element is T) {
        vieM = element;
      }
    });

    if (vieM != null) {
      vieM!.close();
      viewModels.remove(vieM);
    }
  }

  T build(T Function() instance) {
    ZakazyViewModel? vieM;

    viewModels.forEach((element) {
      if (element is T) {
        vieM = element;
      }
    });

    if (vieM == null) {
      vieM = instance();
    }

    viewModels.add(vieM!);

    return vieM as T;
  }
}
