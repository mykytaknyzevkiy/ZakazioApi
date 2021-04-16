import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/model/user/admin/AdminModel.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';

class TopUserOrderChart extends StatelessWidget {
  final String lable;
  final Map<UserInfoModel, double> data;

  const TopUserOrderChart({required this.lable, required this.data});

  @override
  Widget build(BuildContext context) => Card(
    elevation: 12,
    child: Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lable,
            style: TextStyle(
                fontSize: 18
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: 250,
              minWidth: 250,
              maxHeight: 350
            ),
            child: ListView(
              shrinkWrap: true,
              children: List.generate(
                  data.keys.length,
                      (index) {
                    final user = data.keys.toList()[index];
                    final count = data[user]!.toInt();
                    return Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserAvatar(user: user, size: 35),
                        VerticalDivider(
                          width: 15,
                        ),
                        buildRichTextHorizontal("Заказы:", count.toString())
                      ],
                    );
                  }),
            ),
          )
        ],
      ),
    ),
  );

}