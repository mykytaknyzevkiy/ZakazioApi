import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/screen/dashboard/NewDashboardScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/ExecutorShortInfoCard.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';

import '../../conts.dart';
import 'ExecutorInfoViewHolder.dart';

class ExecutorListWidget extends StatelessWidget {
  final BuildContext parentContext;
  final PagedListModel<ExecutorModel> pagedList;
  final Function(int) onPage;

  const ExecutorListWidget(
      {
        Key? key,
        required this.pagedList,
        required this.onPage,
        required this.parentContext}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    children: [
      MediaQuery.of(context).size.width > phoneSize
          ? _Desktop(pagedList.content!, parentContext)
          : _Mobile(pagedList.content!),
      Divider(
        height: 20,
        color: Colors.transparent,
      ),
      PagesWidget(
          pageLength: pagedList.totalPages,
          currentPage: pagedList.number,
          onSelect: (index) {
            onPage(index);
          })
    ],
  );
}

class _Desktop extends StatelessWidget {
  final List<ExecutorModel> data;
  final BuildContext parentContext;

  const _Desktop(this.data, this.parentContext);

  @override
  Widget build(BuildContext context) => SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(data.length, (index) => _viewHolder(data[index])),
      )
  );

  _tableRow(ExecutorModel adminModel) => DataRow(
      cells: [
        //DataCell(Text(adminModel.id.toString())),
        DataCell(Row(
          children: [
            UserAvatar(
              size: 45,
              user: adminModel,
            ),
            VerticalDivider(
              width: 10,
              color: Colors.transparent,
            ),
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: adminModel.firstName),
                      TextSpan(text: " "),
                      TextSpan(text: adminModel.lastName),
                      TextSpan(text: "\n"),
                      TextSpan(
                          text: adminModel.middleName,
                          style: TextStyle(fontSize: 12))
                    ]))
          ],
        )),
        DataCell(Text(adminModel.phoneNumber + "\n" + adminModel.email)),
        DataCell(Text(adminModel.city != null
            ? "${adminModel.city!.region!.name}\n${adminModel.city!.name}"
            : "Не указан")),
        DataCell(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("В работе: " + adminModel.order.count.open.toString()),
            Divider(
              height: 5,
              color: Colors.transparent,
            ),
            Text("Завершено: " + adminModel.order.count.close.toString()),
            Divider(
              height: 5,
              color: Colors.transparent,
            ),
            Text("Отказов: " + adminModel.order.count.declined.toString())
          ],
        )),
        DataCell(Text(adminModel.rate.toString())),
        DataCell(Text(adminModel.balance.toString())),
        DataCell(Text(adminModel.statusTxt())),
      ],
      onSelectChanged: (_) {
        ZakazioNavigator.pushWParams(
            "user/profile", {"userID": adminModel.id});
      });

  _viewHolder(ExecutorModel adminModel) => MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
        onTap: () => ZakazioNavigator.pushWParams(
            "user/profile", {"userID": adminModel.id}),
        child: Card(
            elevation: 4,
            child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UserAvatar(
                                size: 65,
                                user: adminModel,
                              ),
                              VerticalDivider(
                                width: 10,
                                color: Colors.transparent,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${adminModel.firstName} ${adminModel.lastName}\n${adminModel.middleName}",
                                      style: TextStyle(fontSize: 18)),
                                  Divider(
                                    color: Colors.transparent,
                                    height: 10,
                                  ),
                                  buildRichTextHorizontal("Регион", adminModel.city?.region?.name ?? "Не указан"),
                                  Divider(
                                    color: Colors.transparent,
                                    height: 10,
                                  ),
                                  buildRichTextHorizontal("Город", adminModel.city?.name ?? "Не указан"),
                                  Divider(
                                    color: Colors.transparent,
                                    height: 10,
                                  ),
                                  buildRichTextHorizontal("Рейтинг", adminModel.rate.toString()),
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Контакты", style: TextStyle(fontSize: 18)),
                              Divider(
                                color: Colors.transparent,
                                height: 10,
                              ),
                              buildRichTextHorizontal("Телефон", adminModel.phoneNumber),
                              Divider(
                                color: Colors.transparent,
                                height: 10,
                              ),
                              buildRichTextHorizontal("Email", adminModel.email),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Финансы", style: TextStyle(fontSize: 18)),
                              Divider(
                                color: Colors.transparent,
                                height: 10,
                              ),
                              buildRichTextHorizontal("Баланс", formatNumber(adminModel.balance.toInt()) + " руб."),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Заказы", style: TextStyle(fontSize: 18)),
                              Divider(
                                color: Colors.transparent,
                                height: 10,
                              ),
                              buildRichTextHorizontal("Открытые", adminModel.order.count.open.toString()),
                              Divider(
                                color: Colors.transparent,
                                height: 10,
                              ),
                              buildRichTextHorizontal("Завершенные", adminModel.order.count.close.toString()),
                              Divider(
                                color: Colors.transparent,
                                height: 10,
                              ),
                              buildRichTextHorizontal("Отказы", adminModel.order.count.declined.toString())
                            ],
                          )
                        ],
                      ),
                      Divider(
                        height: 15,
                        color: Colors.transparent,
                      ),
                      Container(
                        width: 130,
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(16))),
                        child: Center(
                          child: Text(
                            adminModel.statusTxt(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                )
            )
        )
    ),
  );

}

class _Mobile extends StatelessWidget {
  final List<ExecutorModel> data;

  const _Mobile(this.data);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: data.map((e) => ExecutorInfoViewHolder(e, null)).toList(),
  );

}