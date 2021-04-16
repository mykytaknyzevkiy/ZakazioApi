import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/user/client/ClientModel.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';

class ClientViewHolder extends StatelessWidget {
  final ClientModel _clientModel;

  const ClientViewHolder(this._clientModel);

  @override
  Widget build(BuildContext context) => GestureDetector(
    child: Card(
        elevation: 4,
        child: Container(
          width: double.infinity,
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //width: 145,
                    child: Center(
                      child: UserAvatar(user: _clientModel, size: 75),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 5,
                  ),
                  Container(
                    child: Center(
                      child: Text("${_clientModel.firstName} ${_clientModel.lastName}\n${_clientModel.middleName}"),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 20,
                  ),
                  Text("Заказы", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Divider(
                    color: Colors.transparent,
                    height: 10,
                  ),
                  buildRichTextHorizontal("Открытые", _clientModel.order.count.open.toString()),
                  Divider(
                    color: Colors.transparent,
                    height: 10,
                  ),
                  buildRichTextHorizontal("Завершенные", _clientModel.order.count.close.toString())
                ],
              )
          ),
        )
    ),
    onTap: () => ZakazioNavigator.pushWParams("user/profile", {"userID":  _clientModel.id})
  );
}