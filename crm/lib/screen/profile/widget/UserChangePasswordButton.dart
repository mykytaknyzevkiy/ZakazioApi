import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

// ignore: must_be_immutable
class UserChangePasswordButton extends StatelessWidget {
  final UserInfoModel user;
  VoidCallback onPressed;

  UserChangePasswordButton({required this.user, required this.onPressed});

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
              title: "Изменить пароль",
              onPressed: onPressed,
              isEnable: true,
            ),
          ),
          Divider(
            height: 5,
            color: Colors.transparent,
          )
        ],
      );
}
