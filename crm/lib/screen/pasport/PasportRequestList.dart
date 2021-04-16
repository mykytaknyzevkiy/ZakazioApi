import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/pasport/PasportModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/pasport/PasportRequestInfoScreen.dart';
import 'package:zakazy_crm_v2/screen/pasport/PasportRequestViewModel.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';

class PasportRequestList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PasportRequestListState();
}

class _PasportRequestListState
    extends HomeScreen<PasportRequestList, PasportRequestViewModel> {
  late PasportRequestViewModel _viewModel = viewModel();

  _PasportRequestListState() {
    _viewModel.updateList();
  }

  @override
  Widget rightDialog() => StreamBuilder<PasportModel>(
        stream: _viewModel.onViewInfo,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return PasportRequestInfoScreen(snapShot.requireData);
          }
          return Container();
        },
      );

  @override
  Widget body() => _createTable();

  @override
  int selectedIndex() => 0;

  @override
  Widget top() => Text(
        "Запросы на паспорта",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
      );

  _createTable() {
    return Card(
        elevation: 4,
        child: StreamBuilder<List<PasportModel>>(
          stream: _viewModel.list,
          builder: (context, snapShot) {
            if (snapShot.hasData && snapShot.data != null) {
              return _tables(snapShot.requireData);
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  _tables(List<PasportModel> data) {
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
                'ID',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Пользователь',
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
                'ИНН',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )
          ],
          rows: List<DataRow>.generate(
              data.length, (index) => _tableRow(data[index])),
        ),
      );
  }

  _tableRow(PasportModel pasport) => DataRow(cells: [
        DataCell(Text(pasport.id.toString())),
        DataCell(Row(
          children: [
            UserAvatar(
              size: 45,
              user: pasport.user!,
            ),
            VerticalDivider(
              width: 10,
              color: Colors.transparent,
            ),
            RichText(
                text:
                    TextSpan(style: TextStyle(color: Colors.black), children: [
              TextSpan(text: pasport.user!.firstName),
              TextSpan(text: " "),
              TextSpan(text: pasport.user!.lastName),
              TextSpan(text: "\n"),
              TextSpan(
                  text: pasport.user!.middleName,
                  style: TextStyle(fontSize: 12))
            ]))
          ],
        )),
        DataCell(Text(pasport.user!.city?.name ?? "Не выбран")),
        DataCell(Text(pasport.taxID)),
      ], onSelectChanged: (_) => _viewModel.onViewInfo.add(pasport));

  @override
  PasportRequestViewModel viewModelInstancer() => PasportRequestViewModel();
}