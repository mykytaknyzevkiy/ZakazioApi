import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';

class RatingBarWidget extends StatefulWidget {
  final int rate;
  int _currentRate = 1;

  RatingBarWidget({Key? key, required this.rate}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RatingBarWidget(rate, (n) => _currentRate = n);

  int getRate() => _currentRate;
}

class _RatingBarWidget extends State<RatingBarWidget> {
  int _rate;
  Function(int) _onRate;

  _RatingBarWidget(this._rate, this._onRate);

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: List.generate
        (5,
              (index) => Padding(
                padding: EdgeInsets.only(left: 4, right: 4),
                child: IconButton(
                    icon: Icon(
                      Icons.star_rate,
                      color: (_rate >= (index + 1))
                        ? primaryColor
                        : Colors.grey,
                      size: 32,
                    ),
                    onPressed: () {
                      setState(() {
                        _rate = index + 1;
                        _onRate(_rate);
                      });
                    }
                )
              )
      )
    )
  );

  rate() => _rate;

}