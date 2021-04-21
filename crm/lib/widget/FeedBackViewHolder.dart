import 'dart:html';

import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/feedback/FeedbackModel.dart';

import 'RatingBarWidget.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                      item.order.title,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey
                      )
                  ),
                ),
                Divider(
                  height: 10,
                  color: Colors.transparent,
                ),
                SizedBox(
                    width: 100,
                    child: Text(item.comment)
                ),
              ],
            ),
            Divider(
              height: 10,
              color: Colors.transparent,
            ),
            SizedBox(
                width: 130,
                child: RatingBarWidget(rate: item.stars, isEnable: false, size: 16)
            )
          ],
        )
      )
    )
  );
}