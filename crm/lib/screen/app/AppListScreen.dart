import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/app/AppModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/partner/PartnerModel.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/app/AppCreateScreen.dart';
import 'package:zakazy_crm_v2/screen/app/AppListViewModel.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';

class AppListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppListScreen();
}

class _AppListScreen extends HomeScreen<AppListScreen, AppListViewModel> {
  late AppListViewModel _viewModel = viewModel();

  int _currentPage = 0;

  @override
  Widget rightDialog() => StreamBuilder(
    stream: _viewModel.isToAddApp,
    builder: (context, snapShot) {
      if (snapShot.data == true)
        return AppCreateScreen();
      return Container();
    }
  );

  @override
  void initState() {
    _viewModel.load(_currentPage);
    super.initState();
  }

  @override
  Widget body() => StreamBuilder<PagedListModel<AppModel>>(
    stream: _viewModel.list,
    builder: (context, snapShot) {
      if (!snapShot.hasData)
        return Center(
          child: CircularProgressIndicator(),
        );
      return Card(
        elevation: 12,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  showCheckboxColumn: false,
                  columns: [
                    DataColumn(
                      label: Text(
                        'ID',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Имя',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                  rows: List.generate(
                      snapShot.requireData.content!.length,
                          (index) => DataRow(
                          cells: [
                            DataCell(
                                Text(snapShot.requireData.content![index].id.toString())
                            ),
                            DataCell(
                                Text(snapShot.requireData.content![index].name)
                            )
                          ],
                          onSelectChanged: (_) {
                            ZakazioNavigator.pushWParams("app/info", {"id": snapShot.requireData.content![index].id});
                          }
                      )),
                ),
              ),
              Divider(
                height: 15,
                color: Colors.transparent,
              ),
              PagesWidget(
                  pageLength: snapShot.requireData.totalPages,
                  currentPage: snapShot.requireData.number,
                  onSelect: (index) => _viewModel.load(index))
            ],
          ),
        )
      );
    },
  );

  @override
  Widget top() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Приложение",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
      ),
      Divider(
        height: 20,
        color: Colors.transparent,
      ),
      (UserRepository.instance().myUserLiveData.value!.roleInfo() == RoleType.PARTNER &&
          (UserRepository.instance().myUserLiveData.value! as PartnerModel).order.enable)
      ? MyButton(
        title: "Добавить приложение",
        isEnable: true,
        onPressed: () =>
          _viewModel.isToAddApp.add(true)
        ,
      )
      : Container()
    ],
  );

  @override
  AppListViewModel viewModelInstancer() => AppListViewModel();

}