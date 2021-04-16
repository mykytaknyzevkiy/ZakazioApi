import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/address/RegionModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/address/AddRegionScreen.dart';
import 'package:zakazy_crm_v2/screen/address/RegionViewModel.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';

class RegisonScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegionScreenState();
}

class _RegionScreenState extends HomeScreen<RegisonScreen, RegionViewModel> {
  late RegionViewModel _viewModel = viewModel();

  @override
  Widget rightDialog() {
    return StreamBuilder(
      stream: _viewModel.hasAddEdit,
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          return AddRegionScreen(snapShot.requireData as RegionModel);
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void initState() {
    _viewModel.load(0);
    super.initState();
  }

  @override
  Widget body() => StreamBuilder<PagedListModel<RegionModel>>(
        stream: _viewModel.regions,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _tables(snapShot.requireData.content!),
                Divider(
                  height: 25,
                  color: Colors.transparent,
                ),
                PagesWidget(pageLength: snapShot.requireData.totalPages, currentPage: snapShot.requireData.number, onSelect: _viewModel.load)
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      );

  @override
  int selectedIndex() => 10;

  @override
  Widget top() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Региони",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
        ),
        Divider(height: 25, color: Colors.transparent),
        _createRegionButton(),
      ],
    );
  }

  _createRegionButton() => MyButton(
        title: "Создать регион",
        isEnable: true,
        onPressed: () => {_viewModel.hasAddEdit.add(RegionModel(-10, "", -10))},
      );

  _tables(List<RegionModel> data) {
    return Card(
        elevation: 4,
        child: SizedBox(
            width: double.infinity,
            child: DataTable(
              showCheckboxColumn: false,
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
                    'Имя',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Индек',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Действие',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                )
              ],
              rows: List<DataRow>.generate(
                  data.length, (index) => _tableRow(data[index])),
            )));
  }

  _tableRow(RegionModel item) => DataRow(
          cells: [
            DataCell(Text(item.id.toString())),
            DataCell(Text(item.name)),
            DataCell(Text(item.code.toString())),
            DataCell(FreeButton(
              title: "Изменить",
              isEnable: true,
              onPressed: () {
                _viewModel.hasAddEdit.add(item);
              },
            ))
          ],
          onSelectChanged: (isSelected) => {
                ZakazioNavigator.pushWParams("region/city", {"id": item.id})
              });

  @override
  RegionViewModel viewModelInstancer() => RegionViewModel();
}
