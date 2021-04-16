import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/model/order/OrderModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';
import 'package:zakazy_crm_v2/widget/order/OrderNewViewHolder.dart';

class AdaptiveOrderList extends StatelessWidget {
  final BehaviorSubject<PagedListModel<OrderModel>> stream;
  final Function(int pageNum) onLoad;

  AdaptiveOrderList({Key? key,
    required this.stream,
    required this.onLoad}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<PagedListModel<OrderModel>>(
      stream: stream,
      builder: (context, snapShot) {
        if (!snapShot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: snapShot.requireData.content!.map((e) => OrderNewViewHolder(e)).toList(),
            ),
            Divider(height: 10, color: Colors.transparent),
            PagesWidget(
                pageLength: snapShot.requireData.totalPages,
                currentPage: snapShot.requireData.number,
                onSelect: (index) {
                  onLoad(index);
                })
          ],
        );
      });

}