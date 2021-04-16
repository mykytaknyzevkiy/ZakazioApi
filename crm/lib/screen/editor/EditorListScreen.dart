import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/model/user/editor/EditorModel.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/editor/EditorViewModel.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';
import 'package:zakazy_crm_v2/widget/user/createUser/CreateUserScreen.dart';

class EditorListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditorListScreenState();
}

class _EditorListScreenState
    extends HomeScreen<EditorListScreen, EditorViewModel> {
  late EditorViewModel _viewModel = viewModel();

  final _searchFieldController = TextEditingController();

  int _currentPage = 0;

  _EditorListScreenState() {
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
                roleType: RoleType.EDITOR,
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
  int selectedIndex() => 3;

  @override
  Widget top() {
    return Wrap(
      children: [
        Text(
          "Модераторы",
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
        title: "Добавить модератора",
        isEnable: true,
        onPressed: () => {_viewModel.hasToCreateNew.add(true)},
      );

  @override
  EditorViewModel viewModelInstancer() => EditorViewModel();
}

class _Desktop extends StatelessWidget {
  final BehaviorSubject<List<EditorModel>> list;

  const _Desktop(this.list);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<EditorModel>>(
    stream: list,
    builder: (context, snapShot) {
      if (snapShot.hasData && snapShot.data != null) {
        return _tables(snapShot.requireData);
      }
      return Center(child: CircularProgressIndicator());
    },
  );

  _tables(List<EditorModel> data) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columnSpacing: 0,
        showCheckboxColumn: false,
        dataRowHeight: 70,
        showBottomBorder: true,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'ID',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Аватар',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Полное имя',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Номер телефона',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Email',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          )
        ],
        rows: List<DataRow>.generate(
            data.length, (index) => _tableRow(data[index])),
      ),
    );
  }

  _tableRow(EditorModel adminModel) => DataRow(
      cells: [
        DataCell(Text(adminModel.id.toString())),
        DataCell(UserAvatar(
          size: 45,
          user: adminModel,
        )),
        DataCell(Text(
            "${adminModel.firstName} ${adminModel.lastName}\n${adminModel.middleName}")),
        DataCell(Text(adminModel.phoneNumber)),
        DataCell(Text(adminModel.email))
      ],
      onSelectChanged: (_) {
        ZakazioNavigator.pushWParams(
            "user/profile", {"userID": adminModel.id});
      });

}

class _Mobile extends StatelessWidget {
  final BehaviorSubject<List<EditorModel>> list;

  const _Mobile(this.list);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<EditorModel>>(
    stream: list,
    builder: (_, snapShot) {
      if (!snapShot.hasData) {
        return Center(
          child: CircularProgressIndicator()
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: snapShot.requireData.map((e) => GestureDetector(
          child: _editInfoCard(e),
          onTap: () => ZakazioNavigator.pushWParams(
              "user/profile", {"userID": e.id}),
        )).toList(),
      );
    }
  );

  _editInfoCard(UserInfoModel user) => Card(
    elevation: 4,
    child: Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UserAvatar(user: user, size: 35),
              SizedBox(width: 15),
              Text("${user.firstName} ${user.lastName}\n${user.middleName}")
            ],
          ),
          SizedBox(height: 25),
          buildRichTextHorizontal("Номер телефона", user.phoneNumber),
          SizedBox(height: 10),
          buildRichTextHorizontal("Email", user.email)
        ],
      ),
    ),
  );

}
