import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';
import 'package:zakazy_crm_v2/widget/user/ExecutorInfoViewHolder.dart';
import 'package:zakazy_crm_v2/widget/user/ExecutorListWidget.dart';

class AdaptiveExecutorList extends StatelessWidget {
  final BuildContext parentContext;
  final Function(int pageNum) onChangePage;
  final BehaviorSubject<PagedListModel<ExecutorModel>> list;

  AdaptiveExecutorList(this.list, this.onChangePage, this.parentContext);

  @override
  Widget build(BuildContext context) => StreamBuilder<PagedListModel<ExecutorModel>>(
    stream: list,
    builder: (context, snapShot) {
      if (!snapShot.hasData) {
        return Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          )
        );
      }

      /*return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _list(snapShot.requireData.content!),
          Divider(height: 20, color: Colors.transparent),
          PagesWidget(
              pageLength: snapShot.requireData.totalPages,
              currentPage: snapShot.requireData.number,
              onSelect: (index) {
                onChangePage.call(index);
              })
        ],
      );*/

      return ExecutorListWidget(
        pagedList: snapShot.requireData,
        onPage: (index) {
          onChangePage.call(index);
        },
        parentContext: parentContext,
      );
    }
  );

  _list(List<ExecutorModel> content) => Wrap(
    alignment: WrapAlignment.start,
    crossAxisAlignment: WrapCrossAlignment.start,
    textDirection: TextDirection.ltr,
    spacing: 15,
    runSpacing: 15,
    children: List.generate(
            content.length,
            (index) => SizedBox(
              width: 250,
              child: ExecutorInfoViewHolder(content[index], null),
            )
    ),
  );

}