import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/model/user/client/ClientModel.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';

class OrderClientInfoCard extends StatelessWidget {
  final UserInfoModel _clientInfo;

  const OrderClientInfoCard(this._clientInfo);

  @override
  Widget build(BuildContext context) => Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Заказчик",
              style: TextStyle(fontSize: 16),
            ),
            Center(
              child: UserAvatar(user: _clientInfo, size: 75),
            ),
            Divider(
              height: 25,
              color: Colors.transparent,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.account_box),
                VerticalDivider(
                  width: 10,
                  color: Colors.transparent,
                ),
                Text(
                    "${_clientInfo.firstName} ${_clientInfo.lastName}\n${_clientInfo.middleName}")
              ],
            ),
            Divider(
              height: 15,
              color: Colors.transparent,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.mail),
                VerticalDivider(
                  width: 10,
                  color: Colors.transparent,
                ),
                Text(_clientInfo.email)
              ],
            ),
            Divider(
              height: 15,
              color: Colors.transparent,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.phone),
                VerticalDivider(
                  width: 10,
                  color: Colors.transparent,
                ),
                Text(_clientInfo.phoneNumber)
              ],
            )
          ],
        ),
      ));
}
