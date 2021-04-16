import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/order/OrderCommentModel.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';

class OrderCommentViewHolder extends StatelessWidget {

  final OrderCommentModel _item;

  OrderCommentViewHolder(this._item);

  @override
  Widget build(BuildContext context) => Card(
    elevation: 4,
    child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                UserAvatar(user: _item.user, size: 45),
                VerticalDivider(
                  width: 15,
                  color: Colors.transparent,
                ),
                Text("${_item.user.firstName} ${_item.user.lastName}\n${_item.user.middleName}")
              ],
            ),
            Divider(
              color: Colors.transparent,
              height: 25,
            ),
            Text(_item.text),
            Divider(
              color: Colors.transparent,
              height: 15,
            ),
            Row(
              children: [
                Expanded(child: Container()),
                Text(
                  _item.creationDateTime,
                  style: TextStyle(
                    fontSize: 10
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}