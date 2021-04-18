import 'dart:html';

import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/feedback/FeedbackModel.dart';
import 'package:zakazy_crm_v2/widget/RatingBarWidget.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';

class OrderFeedBackViewHolder extends StatelessWidget {
  final FeedbackModel item;

  const OrderFeedBackViewHolder(this.item);

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: MediaQuery.of(context).size.width > phoneSize
      ? _Desktop(item)
      : _Mobile(item)
  );
}

class _Desktop extends StatelessWidget {
  final FeedbackModel item;

  const _Desktop(this.item);

  @override
  Widget build(BuildContext context) => Card(
      elevation: 4,
      child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserAvatar(user: item.user, size: 75),
                VerticalDivider(
                  width: 5,
                  color: Colors.transparent,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "${item.user.firstName} ${item.user.lastName} ${item.user.middleName}",
                          style: const TextStyle(
                              fontSize: 18
                          )
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(item.comment)
                    ],
                  )
                ),
                SizedBox(
                    width: 200,
                    child: RatingBarWidget(rate: item.stars, isEnable: false)
                )
              ]
          )
      )
  );
}

class _Mobile extends StatelessWidget {
  final FeedbackModel item;

  const _Mobile(this.item);

  @override
  Widget build(BuildContext context) => Card(
      elevation: 4,
      child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.5),
                        border: Border.all(
                            color: primaryColor,
                            width: 2
                        )
                    ),
                    child: Center(
                        child: Text(
                          item.stars.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor
                          ),
                        )
                    )
                ),
                VerticalDivider(
                  width: 10,
                  color: Colors.transparent,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${item.user.firstName} ${item.user.lastName}\n${item.user.middleName}",
                        style: const TextStyle(
                            fontSize: 18
                        )
                    ),
                    Text(item.comment)
                  ],
                )
              ]
          )
      )
  );
}