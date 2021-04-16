import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';

class SplashBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundImage(context),
      child: Container(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleW(),
              Expanded(
                flex: 9,
                child: _description(),
              )
            ],
          ),
        ),
      ),
    );
  }

  _titleW() => Text(
        appName,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 42, color: accentColor),
      );

  _description() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "РЕМОНТНЫЕ РАБОТЫ",
            style: TextStyle(fontSize: 62, color: accentColor),
          ),
          Divider(
            color: Colors.transparent,
            height: 40,
          ),
          Text(
            "Zakazy - Лушкий способ найти исполнителей\nкомнат квартир коттеджей офисов",
            style: TextStyle(fontSize: 24, color: Colors.white70),
          )
        ],
      );
}
