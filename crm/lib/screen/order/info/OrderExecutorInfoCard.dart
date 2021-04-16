import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderInfoViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';

class OrderExecutorInfoCard extends StatelessWidget {
  late OrderInfoViewModel _viewModel = ViewModelProvider<OrderInfoViewModel>().build(() => OrderInfoViewModel());

  final ExecutorModel? _executorInfo;

  OrderExecutorInfoCard(this._executorInfo);

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
                "Исполнитель",
                style: TextStyle(fontSize: 16),
              ),
              Divider(
                height: 25,
                color: Colors.transparent,
              ),
              (_executorInfo == null)
                  ? Center(child: Text("Не назначен"))
                  : _info(),
              Divider(
                height: 15,
                color: Colors.transparent,
              ),
              StreamBuilder(
                stream: _viewModel.exLoading,
                builder: (context, snapShot) {
                  if (snapShot.data == true) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return _viewModel.orderData.value!.cancelExecutorEnable
                  ? Container(
                    child: Center(
                      child: (_executorInfo != null)
                          ? SmallButton(
                        title: "Убрать из заказа",
                        onPressed: () => {
                          _viewModel.cancelExecutor()
                        },
                        isEnable: true,
                        backgroundColor: Colors.redAccent,
                      )
                          : Container(),
                    ),
                  )
                  : Container();
                },
              )
            ],
          )));

  _info() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: UserAvatar(user: _executorInfo!, size: 75),
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
                  "${_executorInfo!.firstName} ${_executorInfo!.lastName}\n${_executorInfo!.middleName}")
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
              Text(_executorInfo!.email)
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
              Text(_executorInfo!.phoneNumber)
            ],
          )
        ],
      );
}
