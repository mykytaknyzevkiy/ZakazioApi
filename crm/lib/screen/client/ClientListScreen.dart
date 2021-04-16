import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/client/ClientModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/client/ClientViewModel.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';
import 'package:zakazy_crm_v2/widget/user/ClientViewHolder.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';
import 'package:zakazy_crm_v2/widget/user/createUser/CreateUserScreen.dart';

class ClientListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClientListScreenState();
}

class _ClientListScreenState
    extends HomeScreen<ClientListScreen, ClientViewModel> {
  late ClientViewModel _viewModel = viewModel();

  final _searchFieldController = TextEditingController();

  int _currentPage = 0;

  _ClientListScreenState() {
    _viewModel.load(_searchFieldController.text, _currentPage, 20);
    _searchFieldController.addListener(() {
      _currentPage = 0;
      _viewModel.load(_searchFieldController.text, _currentPage, 20);
    });
  }

  @override
  Widget rightDialog() => StreamBuilder(
        stream: _viewModel.hasToCreateNew,
        builder: (context, snapShot) {
          if (snapShot.hasData && snapShot.requireData == true) {
            return CreateUserScreen(
                roleType: RoleType.CLIENT,
                onClose: () {
                  _viewModel.hasToCreateNew.add(false);
                  _viewModel.load(
                      _searchFieldController.text, _currentPage, 20);
                });
          } else {
            return Container();
          }
        },
      );

  @override
  Widget body() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _createAdminButton(),
          Divider(height: 30, color: Colors.transparent),
          MediaQuery.of(context).size.width > phoneSize
          ? _Desktop(_viewModel.list)
          : _Mobile(_viewModel.list),
          Divider(height: 20, color: Colors.transparent),
          StreamBuilder<int>(
            stream: _viewModel.pageCount,
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                return PagesWidget(
                    pageLength: snapShot.requireData,
                    currentPage: _currentPage,
                    onSelect: (index) {
                      _currentPage = index;
                      _viewModel.load(
                          _searchFieldController.text, _currentPage, 20);
                    });
              }
              return Container();
            },
          )
        ],
      );

  @override
  int selectedIndex() => 6;

  @override
  Widget top() {
    return Wrap(
      children: [
        Text(
          "Заказчики",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
        ),
        VerticalDivider(
          width: 20,
        ),
        _searchWidget(),
      ],
    );
  }

  _searchWidget() => Padding(
        padding: EdgeInsets.only(right: 8),
        child: SizedBox(
          width: 500,
          child: TextFormField(
              controller: _searchFieldController,
              decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  labelText: 'Поиск',
                  border: OutlineInputBorder())),
        ),
      );

  _createAdminButton() => MyButton(
        title: "Добавить заказчика",
        isEnable: true,
        onPressed: () => {_viewModel.hasToCreateNew.add(true)},
      );

  @override
  ClientViewModel viewModelInstancer() => ClientViewModel();
}

class _Desktop extends StatelessWidget {
  final BehaviorSubject<List<ClientModel>> list;

  const _Desktop(this.list);

  @override
  Widget build(BuildContext context) => Card(
      elevation: 4,
      child: StreamBuilder<List<ClientModel>>(
        stream: list,
        builder: (context, snapShot) {
          if (snapShot.hasData && snapShot.data != null) {
            return _tables(snapShot.requireData);
          }
          return Center(child: CircularProgressIndicator());
        },
      ));

  _tables(List<ClientModel> data) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columnSpacing: 0,
        showCheckboxColumn: false,
        dataRowHeight: 90,
        showBottomBorder: true,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Имя',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Контакты',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Адрес',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Заказы',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          )
        ],
        rows: List<DataRow>.generate(
            data.length, (index) => _tableRow(data[index])),
      ),
    );
  }

  _tableRow(ClientModel adminModel) => DataRow(
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
            Text("Завершено: " + adminModel.order.count.close.toString())
          ],
        )),
      ],
      onSelectChanged: (_) {
        ZakazioNavigator.pushWParams("user/profile", {"userID": adminModel.id});
      });

}

class _Mobile extends StatelessWidget {
  final BehaviorSubject<List<ClientModel>> list;

  const _Mobile(this.list);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<ClientModel>>(
    stream: list,
    builder: (context, snapShot) {
      if (snapShot.hasData) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: snapShot.requireData.map((e) => ClientViewHolder(e)).toList(),
        );
      }
      return Center(child: CircularProgressIndicator());
    },
  );

}
