import 'dart:html';

import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/feedback/FeedbackModel.dart';

class FeedBackViewHolder extends StatelessWidget {
  final FeedbackModel item;

  const FeedBackViewHolder(this.item);

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(37.5),
                border: Border.all(
                    color: primaryColor,
                    width: 2
                )
              ),
              child: Center(
                child: Text(
                  item.stars.toString(),
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: primaryColor
                  ),
                )
              )
            ),
            VerticalDivider(
              width: 25,
              color: Colors.transparent,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Заказ №${item.order.id}",
                  style: const TextStyle(
                    fontSize: 18
                  )
                ),
                Text(
                    item.order.title,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey
                    )
                ),
                Divider(
                  height: 10,
                  color: Colors.transparent,
                ),
                SizedBox(
                  width: 300,
                  child: Flexible(child: Text(item.comment)),
                )
              ],
            )
          ]
        )
      )
    )
  );
}