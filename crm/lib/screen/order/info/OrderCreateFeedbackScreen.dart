import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderInfoViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/RatingBarWidget.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';

class OrderCreateFeedbackScreen extends StatelessWidget {
  final OrderInfoViewModel _viewModel = ViewModelProvider<OrderInfoViewModel>()
      .build(
          () => OrderInfoViewModel()
  );

  final _commentFiled = ZTextField(hint: "Отзыв", isMultiline: true, maxLength: 150);
  final RatingBarWidget _ratingBar = RatingBarWidget(rate: 1);

  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height,
    child: Card(
      elevation: 12,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 48, top: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Оставить отзыв",
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Divider(
              color: Colors.transparent,
              height: 40,
            ),
            _ratingBar,
            Divider(
              height: 25,
              color: Colors.transparent,
            ),
            _commentFiled,
            Divider(
              color: Colors.transparent,
              height: 25,
            ),
            StreamBuilder<bool>(
              stream: _viewModel.exLoading,
              builder: (context, snapShot) {
                if (!snapShot.hasData || snapShot.requireData == false)
                  return _btnColum();
                else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              },
            )
          ]
        )
      )
    )
  );

  _btnColum() => SizedBox(
    width: 300,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MyButton(
          title: "Отправить",
          onPressed: () => _onSaveClick(),
          isEnable: true,
        ),
        FreeButton(
          title: "Отменить",
          onPressed: () => _onCancelCLick(),
          isEnable: true,
        )
      ],
    ),
  );

  _onSaveClick() {
    if (_commentFiled.text().isEmpty) {
      _commentFiled.setError("Заполните поле");
      return;
    }

    _viewModel.sendFeedback(_commentFiled.text(), _ratingBar.getRate());
  }

  _onCancelCLick() {
    _viewModel.rightDialog.add(null);
  }

}