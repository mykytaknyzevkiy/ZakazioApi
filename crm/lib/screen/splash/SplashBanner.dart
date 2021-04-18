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
            "ПАРТНЕРСТВО ЗА % С ДОГОВОРА\n"+
                "CRM и ERP Система контроля\n"+
                "заказов и исполнителей в 127\n"
                    "нишах услуг в РФ и СНГ",
            style: TextStyle(fontSize: 48, color: accentColor),
          ),
          Divider(
            color: Colors.transparent,
            height: 40,
          ),
          Text(
            "*ТРАФИК х ЗАЯВКИ = СДЕЛКИ*\n"+
  "СОЗДАЙ, СВОЮ НЕЙРОСЕТЬ...",
            style: TextStyle(fontSize: 32, color: accentColor),
          )
        ],
      );
}
