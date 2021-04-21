import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/screen/dashboard/NewDashboardScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileViewModel.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/payment/AddBalanceAlert.dart';
import 'package:zakazy_crm_v2/widget/payment/CloudPaymnet3dsAlert.dart';

class UserBalanceCard extends StatelessWidget {

  final UserProfileViewModel viewModel;

  const UserBalanceCard(this.viewModel);

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 300,
    child: FutureBuilder<double>(
      future: viewModel.balance(),
      builder: (context, snapShot) {
        if (!snapShot.hasData) {
          return Center(
              child: CircularProgressIndicator()
          );
        }
        return Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Баланс",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(
                  height: 25,
                  color: Colors.transparent
              ),
              Text(
                "${formatNumber(snapShot.requireData.toInt())} руб.",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              (viewModel.userInfo.value!.canBeEdit())
                  ? Row(
                children: [
                  Expanded(child: Container()),
                  FloatingActionButton(
                    onPressed: () => viewModel.onAddBalance(),
                    child: Icon(Icons.add),
                  )
                ],
              )
                  : Container()
            ],
          ),
        );
      },
    ),
  );
}