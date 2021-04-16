import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';

class ExecutorInfoViewHolder extends StatelessWidget {
  final ExecutorModel _executor;
  final Function()? _onSelect;

  ExecutorInfoViewHolder(this._executor, this._onSelect);

  @override
  Widget build(BuildContext context) => Card(
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
                      child: UserAvatar(user: _executor, size: 75),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 5,
                  ),
                  Container(
                    child: Center(
                      child: Text("${_executor.firstName} ${_executor.lastName}\n${_executor.middleName}"),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 15,
                  ),
                  buildRichTextHorizontal("Рейтинг", _executor.rate.toString()),
                  Divider(
                    color: Colors.transparent,
                    height: 20,
                  ),
                  Text("Заказы", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Divider(
                    color: Colors.transparent,
                    height: 10,
                  ),
                  buildRichTextHorizontal("Открытые", _executor.order.count.open.toString()),
                  Divider(
                    color: Colors.transparent,
                    height: 10,
                  ),
                  buildRichTextHorizontal("Завершенные", _executor.order.count.close.toString()),
                  Divider(
                    color: Colors.transparent,
                    height: 20,
                  ),
                  (_onSelect != null)
                  ? SizedBox(
                    width: double.infinity,
                    child: SmallButton(title: "Выбрать", onPressed: () => {
                      _onSelect!.call()
                    }, isEnable: _executor.order.enable),
                  )
                  : Container(),
                  Divider(
                    color: Colors.transparent,
                    height: 5,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: SmallButton(
                        title: "В профиль",
                        onPressed: () => {
                          ZakazioNavigator.pushWParams(
                              "user/profile", {"userID": _executor.id}
                              )
                        },
                        isEnable: true,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black
                    ),
                  )
                ],
              )
          ),
        )
      );
}
