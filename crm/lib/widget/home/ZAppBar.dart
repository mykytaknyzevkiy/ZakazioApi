import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

class ZAppBar extends StatelessWidget {
  final UserInfoModel myUser;

  const ZAppBar({required this.myUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: accentColor,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_title(), _userData()],
        ),
      ),
    );
  }

  _userData() => Row(
        children: [
          UserAvatar(user: myUser, size: 40),
          VerticalDivider(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${myUser.firstName} ${myUser.lastName}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Divider(
                height: 3,
              ),
              Text(
                "${myUser.roleInfo().name()}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                ),
              )
            ],
          )
        ],
      );

  _title() => Text(
        appName,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      );
}
