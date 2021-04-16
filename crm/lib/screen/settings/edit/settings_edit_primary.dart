import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/settings/SettingsFullVM.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';

class SettingseditPrimary extends StatelessWidget {
  final _viewModel = ViewModelProvider<SettingsFullViewModel>()
      .build(() => SettingsFullViewModel());

  final _orderOutProcentFiled = ZTextField(
      hint: "Комисия за заказ у исполнителя",
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      keyBoardType: TextInputType.number);

  final _orderPartnerProcentFiled = ZTextField(
      hint: "Вознограждение партнера заказа",
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      keyBoardType: TextInputType.number);

  final _agentExecutorProcentFiled = ZTextField(
      hint: "Вознограждение агента исполнителя",
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      keyBoardType: TextInputType.number);

  SettingseditPrimary() {
    final data = _viewModel.primary.value!;

    _orderOutProcentFiled.setText(data.orderSumOutPercent.toString());
    _orderPartnerProcentFiled.setText(data.orderPartnerPercent.toString());
    _agentExecutorProcentFiled.setText(data.executorPartnerPercent.toString());
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Изменить аукцион",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Divider(
                    height: 40,
                    color: Colors.transparent,
                  ),
                  _orderOutProcentFiled,
                  Divider(
                    height: 15,
                    color: Colors.transparent,
                  ),
                  _orderPartnerProcentFiled,
                  Divider(
                    height: 15,
                    color: Colors.transparent,
                  ),
                  _agentExecutorProcentFiled,
                  Divider(
                    height: 25,
                    color: Colors.transparent,
                  ),
                  StreamBuilder(
                      stream: _viewModel.onExLoading,
                      builder: (_, snapShot) {
                        if (snapShot.data == true) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return btns();
                      })
                ],
              ),
            ),
          ),
        ),
      );

  btns() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyButton(
            title: "Сохранить",
            onPressed: () {
              final orderOut = int.tryParse(_orderOutProcentFiled.text());
              final partner = int.tryParse(_orderPartnerProcentFiled.text());
              final agent = int.tryParse(_agentExecutorProcentFiled.text());

              if (orderOut == null || orderOut <= 0) {
                _orderOutProcentFiled.setError("");
                return;
              }

              if (partner == null || orderOut < 0) {
                _orderPartnerProcentFiled.setError("");
                return;
              }

              if (agent == null || agent < 0) {
                _agentExecutorProcentFiled.setError("");
                return;
              }

              if ((partner + agent) >= 100) {
                _agentExecutorProcentFiled.setError("");
                _orderPartnerProcentFiled.setError("");
                _orderOutProcentFiled.setError("");
                return;
              }

              final data = _viewModel.primary.value!;

              data.executorPartnerPercent = agent;
              data.orderPartnerPercent = partner;
              data.orderSumOutPercent = orderOut;

              _viewModel.editPrimary(data);
            },
            isEnable: true,
          ),
          FreeButton(
            title: "Отменить",
            onPressed: () => _viewModel.onEdit.add(null),
            isEnable: true,
          )
        ],
      );
}
