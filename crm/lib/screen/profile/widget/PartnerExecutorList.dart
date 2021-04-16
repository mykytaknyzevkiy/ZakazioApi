import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/model/user/partner/PartnerModel.dart';
import 'package:zakazy_crm_v2/rest/executor/ExecutorRest.dart';
import 'package:zakazy_crm_v2/widget/user/AdaptiveExecutorList.dart';

class PartnerExecutorList extends StatelessWidget {
  final PartnerModel _partnerModel;

  final _executorRest = ExecutorRest();

  final list = BehaviorSubject<PagedListModel<ExecutorModel>>.seeded(null);
  int currentPage = 0;

  PartnerExecutorList(this._partnerModel) {
    _load();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Исполнители",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Divider(
          height: 25,
          color: Colors.transparent,
        ),
        AdaptiveExecutorList(list, (index) {
          currentPage = index;
          _load();
        },
            context)
      ],
    ),
  );

  _load() async {
    list.add(null);
    final data = await _executorRest.listOfOwner(_partnerModel.id, '', currentPage, 20);
    if (data.success) {
      list.add(data.data!);
    } else {
      list.add(PagedListModel(List.empty(), 0));
    }
  }

  close() {
    list.close();
  }

}