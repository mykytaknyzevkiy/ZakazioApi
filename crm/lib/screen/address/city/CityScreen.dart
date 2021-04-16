import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/address/RegionModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/address/city/AddCityScreen.dart';
import 'package:zakazy_crm_v2/screen/address/city/CityViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

class CityScreen extends StatefulWidget {
  final int regionID;

  const CityScreen({required this.regionID});

  @override
  State<StatefulWidget> createState() => _CityScreenState(regionID: regionID);
}

class _CityScreenState extends HomeScreen<CityScreen, CityViewModel> {
  final int regionID;

  late CityViewModel _viewModel = viewModel();

  _CityScreenState({required this.regionID}) {
    _viewModel.load(regionID);
  }

  @override
  Widget rightDialog() {
    return StreamBuilder(
      stream: _viewModel.hasAddEdit,
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          return AddCityScreen(regionID, snapShot.requireData as CityModel);
        }
        return Container();
      },
    );
  }

  @override
  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _createRegionButton(),
        Divider(height: 50, color: Colors.transparent),
        SizedBox(width: double.infinity, child: _regionTable())
      ],
    );
  }

  @override
  int selectedIndex() => 10;

  @override
  Widget top() {
    return Text(
      "Города",
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
    );
  }

  _createRegionButton() => MyButton(
        title: "Добавить город",
        isEnable: true,
        onPressed: () => {
          _viewModel.hasAddEdit
              .add(CityModel(-10, "", -10, RegionModel(-10, "", -10)))
        },
      );

  _regionTable() {
    return Card(
        elevation: 4,
        child: StreamBuilder(
          stream: _viewModel.cities,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return _tables(snapShot.requireData as List<CityModel>);
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  _tables(List<CityModel> data) {
    return DataTable(
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
    );
  }

  _tableRow(CityModel item) => DataRow(cells: [
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
      ], onSelectChanged: (isSelected) => {});

  @override
  CityViewModel viewModelInstancer() => CityViewModel();
}
