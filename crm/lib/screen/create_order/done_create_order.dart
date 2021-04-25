import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zakazy_crm_v2/screen/create_order/create_order_main.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

class DoneCreateOrder extends CreateOrderStateScreen {
  DoneCreateOrder()
      :
        super(
          CreateOrderState.DONE,
          "Ваш заказ размещён и добавлен в общую базу.\nОжидайте скоро специалисты свами свяжутся.",
          () => {}
      );

  @override
  Widget content(BuildContext context) => Center(
    child: MyButton(
      title: "Открыть профиль",
      onPressed: () => ZakazioNavigator.push(context, "user/profile/my"),
      isEnable: true,
    )
  );

}