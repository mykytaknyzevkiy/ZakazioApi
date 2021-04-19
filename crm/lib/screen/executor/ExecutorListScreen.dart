import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/executor/ExecutorViewModel.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/CityAutoTextFieldFixed.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';
import 'package:zakazy_crm_v2/widget/UserStatusSelectWidget.dart';
import 'package:zakazy_crm_v2/widget/user/ExecutorListWidget.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';
import 'package:zakazy_crm_v2/widget/user/createUser/CreateUserScreen.dart';

class ExecutorListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExecutorListScreenState();
}

class _ExecutorListScreenState
    extends HomeScreen<ExecutorListScreen, ExecutorViewModel> {
  late ExecutorViewModel _viewModel = viewModel();

  final _searchFieldController = TextEditingController();

  int _currentPage = 0;

  String? _currentStatus;
  CityModel? _currentCity;

  _ExecutorListScreenState() {
    _searchFieldController.addListener(() {
      _currentPage = 0;
      doLoad();
    });
  }

  @override
  void initState() {
    doLoad();
    super.initState();
  }

  @override
  Widget rightDialog() => StreamBuilder(
        stream: _viewModel.hasToCreateNew,
        builder: (context, snapShot) {
          if (snapShot.hasData && snapShot.requireData == true) {
            return CreateUserScreen(
                roleType: RoleType.EXECUTOR,
                onClose: () {
                  _viewModel.hasToCreateNew.add(false);
                  _currentPage = 0;
                  doLoad();
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
          _searchWidget(),
          Divider(height: 30, color: Colors.transparent),
          MediaQuery.of(context).size.width > phoneSize
          ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: list()),
              SizedBox(width: 25),
              filters()
            ],
          )
          : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              filters(),
              SizedBox(height: 25),
              list()
            ],
          )
        ],
      );

  @override
  int selectedIndex() => 5;

  @override
  Widget top() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Исполнители",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
        )
      ],
    );
  }

  _searchWidget() => Padding(
        padding: EdgeInsets.only(right: 8),
        child: SizedBox(
          width: double.infinity,
          child: TextFormField(
              controller: _searchFieldController,
              decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  labelText: 'Поиск',
                  border: OutlineInputBorder())),
        ),
      );

  _createAdminButton() => MyButton(
        title: "Добавить исполнителя",
        isEnable: true,
        onPressed: () => {_viewModel.hasToCreateNew.add(true)},
      );

  @override
  ExecutorViewModel viewModelInstancer() => ExecutorViewModel();

  doLoad() {
    _viewModel.load(_searchFieldController.text, _currentPage, _currentStatus, _currentCity);
  }

  filters() => Card(
    elevation: 4,
    child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Фильтр", style: TextStyle(fontSize: 18)),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 300,
              child: CityAutoTextFieldFixed(
                      (city) {
                        _currentCity = city;
                        _currentPage = 0;
                        doLoad();
                      }),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              child: UserStatusSelectWidget(
                onSelected: (status) {
                  _currentStatus = status;
                  _currentPage = 0;
                  doLoad();
                },
              ),
            )
          ],
        )),
  );

  list() => StreamBuilder<PagedListModel<ExecutorModel>>(
      stream: _viewModel.list,
      builder: (_, snapShot) {
        if (!snapShot.hasData)
          return Center(
              child: CircularProgressIndicator()
          );
        return ExecutorListWidget(
          pagedList: snapShot.requireData,
          onPage: (page) {
            _currentPage = page;
            doLoad();
          },
          parentContext: context,
        );
      }
  );
}
