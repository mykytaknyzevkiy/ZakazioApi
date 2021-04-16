import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zakazy_crm_v2/model/payment/BankCardModel.dart';

class BankCardViewHolder extends StatelessWidget {

  final BankCardModel item;

  const BankCardViewHolder({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: SystemMouseCursors.click,
    child: Card(
      elevation: 4,
      child: SizedBox(
        width: 300,
        height: 185,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "****  ****  ****  ${item.endNum.substring(11)}",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                item.exp,
                style: TextStyle(
                    fontSize: 18
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );

}