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
          padding: const EdgeInsets.all(8),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAvatar(
                  user: item.user,
                  size: 55,
                ),
                VerticalDivider(
                  width: 5,
                  color: Colors.transparent,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                          "${item.user.firstName} ${item.user.lastName} ${item.user.middleName}",
                          style: const TextStyle(
                              fontSize: 18
                          )
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(item.comment),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: 130,
                        child: RatingBarWidget(rate: item.stars, isEnable: false, size: 16)
                    )
                  ],
                )
              ]
          )
      )
  );
}