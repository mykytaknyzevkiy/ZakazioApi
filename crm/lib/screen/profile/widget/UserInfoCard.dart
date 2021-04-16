import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';

class UserInfoCard extends StatelessWidget {
  final UserInfoModel _user;
  final Function()? _onEditClick;
  final String? _label;

  UserInfoCard(this._user, this._onEditClick, this._label);

  @override
  Widget build(BuildContext context) => Card(
      elevation: 4,
      child: Container(
        constraints: BoxConstraints(minWidth: 300),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (_label != null)
              ? Text(
                _label!,
                style: TextStyle(
                  fontSize: 18
                ))
               : Container(),
              Divider(
                height: 20,
                color: Colors.transparent,
              ),
              UserAvatar(user: _user, size: 100),
              Divider(
                color: Colors.transparent,
                height: 10,
              ),
              dataInfoField("Имя", _user.firstName),
              Divider(
                color: Colors.transparent,
                height: 10,
              ),
              dataInfoField("Фамилия", _user.lastName),
              Divider(
                color: Colors.transparent,
                height: 10,
              ),
              dataInfoField("Отчество", _user.middleName),
              Divider(
                color: Colors.transparent,
                height: 10,
              ),
              dataInfoField("Номер телефона", _user.phoneNumber),
              Divider(
                color: Colors.transparent,
                height: 10,
              ),
              dataInfoField("Email", _user.email),
              Divider(
                color: Colors.transparent,
                height: 10,
              ),
              dataInfoField(
                  "Город", _user.city != null ? _user.city!.name : "Не выбран"),
              Divider(
                color: Colors.transparent,
                height: 20,
              ),
              (_onEditClick != null)
              ? editBtn()
              : Container()
            ],
          ),
        ),
      ));

  topExtrenal() {
    if (_user.roleInfo() == RoleType.EXECUTOR) {
      final executor = _user as ExecutorModel;

      return Center(
        child: RatingBar.builder(
          initialRating: executor.rate,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: false,
          ignoreGestures: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
          },
        ),
      );
    }

    return Container();
  }

  editBtn() => FloatingActionButton(
        onPressed: _onEditClick,
        child: Icon(Icons.edit),
      );
}
