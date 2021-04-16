import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

// ignore: must_be_immutable
class BlockActiveUserButton extends StatelessWidget {
  final UserInfoModel user;
  VoidCallback onPressed;

  BlockActiveUserButton({required this.user, required this.onPressed});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Divider(
            height: 5,
            color: Colors.transparent,
          ),
          Container(
            constraints: BoxConstraints(minWidth: 300),
            child: MyButton(
              title: user.isBlocked() ? "Разблокировать" : "Заблокировать",
              onPressed: onPressed,
              isEnable: true,
              backgroundColor:
                  user.isBlocked() ? Colors.greenAccent : Colors.redAccent,
            ),
          ),
          Divider(
            height: 5,
            color: Colors.transparent,
          )
        ],
      );
}
