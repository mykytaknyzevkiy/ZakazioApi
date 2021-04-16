import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/order/OrderModel.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

class OrderNewViewHolder extends StatelessWidget {
  final OrderModel item;

  const OrderNewViewHolder(this.item);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          ZakazioNavigator.pushWParams("order/info", {"id": item.id});
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Card(
            elevation: 4,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                  padding: EdgeInsets.all(24),
                  child: MediaQuery.of(context).size.width > phoneSize
                  ? _Desktop(item)
                  : _Mobile(item)
              ),
            ),
          ),
        ),
      );
}

class _Desktop extends StatelessWidget {
  final OrderModel item;

  const _Desktop(this.item);

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            constraints: BoxConstraints(minHeight: 200),
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  runSpacing: 15,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: _categoryBox(),
                    ),
                    SizedBox(
                      width: 250,
                      child: _infoBox(),
                    ),
                    _addressBox(),
                    _priceBox()
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(item.dateStr()),
          )
        ],
      ),
      Align(
        alignment: Alignment.topRight,
        child: _status(),
      )
    ],
  );

  _categoryBox() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      CircleAvatar(
          backgroundImage: NetworkImage(fileUrl(item.category.imageUrl)),
          radius: 35),
      Divider(
        height: 10,
        color: Colors.transparent,
      ),
      Text(item.category.name, textAlign: TextAlign.center)
    ],
  );

  _infoBox() => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        item.title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      Divider(
        color: Colors.transparent,
        height: 15,
      ),
      Text(
        item.content,
        maxLines: 5,
      )
    ],
  );

  _addressBox() => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.location_on,
        size: 55,
        color: primaryColor,
      ),
      VerticalDivider(
        width: 10,
        color: Colors.transparent,
      ),
      SizedBox(
        width: 150,
        child: Text(
          "${item.city.region!.name},\n${item.city.name}",
          style: TextStyle(fontSize: 16),
        ),
      )
    ],
  );

  _priceBox() => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.account_balance_wallet,
        size: 55,
        color: primaryColor,
      ),
      VerticalDivider(
        width: 10,
        color: Colors.transparent,
      ),
      SizedBox(
        width: 150,
        child: Text(
          "${item.price} руб.",
          style: TextStyle(fontSize: 16),
        ),
      )
    ],
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

}

class _Mobile extends StatelessWidget {
  final OrderModel item;

  const _Mobile(this.item);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Container()),
          _status()
        ],
      ),
      SizedBox(
        height: 15
      ),
      Text(
          item.title,
          style: TextStyle(
              fontSize: 18
          )
      ),
      SizedBox(
        height: 5,
      ),
      Text(item.content),
      SizedBox(
        height: 25,
      ),
      _addressBox(),
      SizedBox(
        height: 10,
      ),
      _priceBox(),
      SizedBox(
        height: 25,
      ),
      Row(
        children: [
          Expanded(child: Container()),
          Text(
            item.dateStr(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey
            ),
          )
        ],
      )
    ],
  );

  _status() => Container(
    width: 100,
    height: 25,
    decoration: BoxDecoration(
        color: item.statusInfo().color(),
        borderRadius: BorderRadius.all(Radius.circular(16))),
    child: Center(
      child: Text(
        item.statusInfo().name(),
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    ),
  );

  _addressBox() => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.location_on,
        size: 25,
        color: primaryColor,
      ),
      VerticalDivider(
        width: 10,
        color: Colors.transparent,
      ),
      SizedBox(
        width: 100,
        child: Text(
          "${item.city.region!.name},\n${item.city.name}",
          style: TextStyle(fontSize: 14),
        ),
      )
    ],
  );

  _priceBox() => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.account_balance_wallet,
        size: 25,
        color: primaryColor,
      ),
      VerticalDivider(
        width: 10,
        color: Colors.transparent,
      ),
      SizedBox(
        width: 100,
        child: Text(
          "${item.price} руб.",
          style: TextStyle(fontSize: 14),
        ),
      )
    ],
  );
}
