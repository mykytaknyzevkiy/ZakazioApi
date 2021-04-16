import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/rest/executor/ExecutorRest.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderInfoViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/widget/user/ExecutorInfoViewHolder.dart';

class OrderFindExecutorScreen extends StatelessWidget {
  late OrderInfoViewModel _viewModel = ViewModelProvider<OrderInfoViewModel>().build(() => OrderInfoViewModel());

  late ZTextField _searchField = ZTextField(hint: "Поиск", onEdit: _onSearch);

  final _executorList = BehaviorSubject<List<ExecutorModel>>.seeded([]);

  final _executorRest = ExecutorRest();

  _onSearch(String text) async {
    final data = await _executorRest.list(text, 0, 20);
    if (data.success && data.data != null) {
      _executorList.add(data.data!.content);
    }
  }

  _close() {
    _executorList.close();
  }

  OrderFindExecutorScreen() {
    _onSearch("");
  }

  @override
  Widget build(BuildContext context) => Card(
        elevation: 12,
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 48),
          child: StreamBuilder(
            stream: _viewModel.exLoading,
            builder: (context, snapShot) {
              if (snapShot.data == true) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Найти исполнителя",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Divider(
                    color: Colors.transparent,
                    height: 40,
                  ),
                  _searchField,
                  Divider(
                    color: Colors.transparent,
                    height: 15,
                  ),
                  Expanded(child: _listView()),
                  Divider(
                    color: Colors.transparent,
                    height: 25,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: MyButton(
                      title: "Отменить",
                      isEnable: true,
                      onPressed: () => {
                        _viewModel.rightDialog.add(null)
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
      );

  _listView() => StreamBuilder<List<ExecutorModel>>(
        stream: _executorList,
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final list = snapShot.requireData;

          return SingleChildScrollView(
            child: Column(
                children: List.generate(
                    list.length, (index) => ExecutorInfoViewHolder(list[index], () => {
                      _viewModel.setExecutor(list[index])
                }))),
          );
        },
      );
}
