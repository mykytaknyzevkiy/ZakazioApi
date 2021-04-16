import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/order/OrderModel.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

class OrderViewHolder extends StatelessWidget {
  final OrderModel item;

  const OrderViewHolder(this.item);

  //static final appContainer = html.window.document.getElementById('app-container');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _client(),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  color: accentColor,
                  elevation: 4,
                  margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(child: Column(
                              children: [
                                buildRichTextHorizontal("Категория", item.category.name),
                                Divider(
                                  height: 10,
                                  color: Colors.transparent,
                                ),
                                _title()
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            )),
                            _status()
                          ],
                        ),
                        Divider(
                          height: 20,
                          color: Colors.transparent,
                        ),
                        _description(),
                        Divider(
                          height: 50,
                          color: Colors.transparent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [_city(), _price()],
                        ),
                        Divider(
                          height: 20,
                          color: Colors.transparent,
                        ),
                        Divider(
                          height: 10,
                          color: Colors.grey.withAlpha(70),
                        ),
                        Divider(
                          height: 10,
                          color: Colors.transparent,
                        ),
                        _executor()
                      ],
                    ),
                  )),
            )
          ],
        ));
  }

  _title() => Text(
        item.title,
        style: TextStyle(fontSize: 24),
      );

  _description() => Text(
        item.content,
        style: TextStyle(fontSize: 14),
      );

  _city() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.location_city,
            size: 18,
            color: Colors.grey,
          ),
          VerticalDivider(
            width: 5,
          ),
          Text(
            item.city.name,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )
        ],
      );

  _price() => Text(
        "${item.price} RUB",
        style: TextStyle(fontWeight: FontWeight.bold),
      );

  _executor() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Испонитель:"),
          Divider(
            height: 10,
            color: Colors.transparent,
          ),
          (item.executor == null)
              ? Text("Отсуствует", style: TextStyle(fontSize: 12))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UserAvatar(user: item.executor!, size: 35),
                    VerticalDivider(
                      width: 10,
                      color: Colors.transparent,
                    ),
                    Text(
                      "${item.executor!.firstName} ${item.executor!.lastName}\n${item.executor!.middleName}",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                )
        ],
      );

  _client() => Container(
        margin: EdgeInsets.only(left: 8, right: 8, top: 24, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserAvatar(user: item.client, size: 60),
            VerticalDivider(
              width: 10,
              color: Colors.transparent,
            ),
            Text(
                "${item.client.firstName} ${item.client.lastName}\n${item.client.middleName}")
          ],
        ),
      );

  _status() => Container(
        width: 130,
        height: 30,
        decoration: BoxDecoration(
            color: item.statusInfo().color(),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Center(
          child: Text(
            item.statusInfo().name(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  _date() => Text(
    item.dateStr(),
    style: TextStyle(fontSize: 12),
  );
}
