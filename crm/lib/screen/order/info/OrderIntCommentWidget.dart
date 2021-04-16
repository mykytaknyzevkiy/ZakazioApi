import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/order/OrderCommentModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderInfoViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/widget/order/OrderCommentViewHolder.dart';
import 'package:zakazy_crm_v2/widget/payment/OrderTransactionList.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';

class OrderInfoCommentWidget extends StatelessWidget {
  late OrderInfoViewModel _viewModel =
      ViewModelProvider<OrderInfoViewModel>().build(() => OrderInfoViewModel());

  final _textField = ZTextField(
    hint: "Ваш комментарий",
    isMultiline: true,
    maxLength: 255,
  );

  late MyButton _saveBtn =
      MyButton(title: "Отправить", onPressed: onAddComment, isEnable: false);

  OrderInfoCommentWidget() {
    _textField.onEdit = (text) {
      _saveBtn.setEnable(text.isNotEmpty);
    };
    _viewModel.loadComments(0);
  }

  @override
  Widget build(BuildContext context) => Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Комментарии",
              style: TextStyle(fontSize: 16),
            ),
            Divider(
              height: 25,
              color: Colors.transparent,
            ),
            _textField,
            Divider(
              height: 10,
              color: Colors.transparent,
            ),
            Row(
              children: [
                Expanded(child: Container()),
                StreamBuilder(
                  stream: _viewModel.exLoading,
                  builder: (context, snapShot) {
                    if (snapShot.data == true) {
                      return CircularProgressIndicator();
                    }
                    return _saveBtn;
                  },
                )
              ],
            ),
            Divider(
              height: 25,
              color: Colors.transparent,
            ),
            StreamBuilder<PagedListModel<OrderCommentModel>>(
              stream: _viewModel.comments,
              builder: (context, snapShot) {
                if (!snapShot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MediaQuery.of(context).size.width > phoneSize
                    ? _Desktop(snapShot.requireData.content!)
                    : _Mobile(snapShot.requireData.content!),
                    Divider(height: 20, color: Colors.transparent),
                    PagesWidget(
                        pageLength: snapShot.requireData.totalPages,
                        currentPage: snapShot.requireData.number,
                        onSelect: (_) => {})
                  ],
                );
              },
            )
          ],
        ),
      )
  );

  onAddComment() async {
    await _viewModel.addComment(_textField.text());
    _textField.setText("");
  }
}

class _Desktop extends StatelessWidget {
  final List<OrderCommentModel> list;

  const _Desktop(this.list);

  @override
  Widget build(BuildContext context) => SizedBox(
      width: double.infinity,
      child: DataTable(
        //dataRowHeight: 200,
          columns: _tableColumns(),
          rows: _tableRows(list)
      )
  );

  _tableColumns() => [
    BaseColumn("Пользователь"),
    BaseColumn("Текст"),
    BaseColumn("Дата"),
  ];

  List<DataRow> _tableRows(List<OrderCommentModel> list) => list
      .map((e) => DataRow(
      cells: [
        DataCell(Row(
          children: [
            UserAvatar(
              size: 45,
              user: e.user,
            ),
            SizedBox(width: 15),
            Text(
                "${e.user.firstName} ${e.user.lastName}\n${e.user.middleName}")
          ],
        )),
        DataCell(SizedBox(
          width: 300,
          child: Text(e.text),
        )),
        DataCell(Text(e.dateStr()))
      ]))
      .toList();
}

class _Mobile extends StatelessWidget {
  final List<OrderCommentModel> list;

  const _Mobile(this.list);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(list.length, (index)  {
      final e = list[index];
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 5,
            color: Colors.transparent,
          ),
          Row(
            children: [
              UserAvatar(
                size: 45,
                user: e.user,
              ),
              SizedBox(width: 15),
              Text(
                  "${e.user.firstName} ${e.user.lastName}\n${e.user.middleName}")
            ],
          ),
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          SizedBox(
            width: 100,
            child: Text(
              e.text,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Divider(
            height: 11,
            color: Colors.grey,
          ),
        ],
      );
    }),
  );
}
