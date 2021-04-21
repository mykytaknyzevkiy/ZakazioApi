import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/address/RegionModel.dart';
import 'package:zakazy_crm_v2/model/user/partner/PartnerModel.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/dashboard/NewDashboardScreen.dart';
import 'package:zakazy_crm_v2/screen/partner/PartnerViewModel.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/CityAutoTextFieldFixed.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';
import 'package:zakazy_crm_v2/widget/RegionAutoTextFieldFixed.dart';
import 'package:zakazy_crm_v2/widget/UserStatusSelectWidget.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';
import 'package:zakazy_crm_v2/widget/user/createUser/CreateUserScreen.dart';

class PartnerListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PartnerListScreenState();
}

class _PartnerListScreenState
    extends HomeScreen<PartnerListScreen, PartnerViewModel> {
  late PartnerViewModel _viewModel = viewModel();

  final _searchFieldController = TextEditingController();

  int _currentPage = 0;

  String? _currentStatus;

  CityModel? _currentCity;

  RegionModel? _currentRegion;

  _PartnerListScreenState() {
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
                roleType: RoleType.PARTNER,
                onClose: () {
                  _viewModel.hasToCreateNew.add(false);
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
          MediaQuery.of(context).size.width > phoneSize
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: list()
                    ),
                  )
              ),
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
  int selectedIndex() => 4;

  @override
  Widget top() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Партнеры",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
        )
      ],
    );
  }

  _searchWidget() => SizedBox(
    width: 300,
    child: TextFormField(
        controller: _searchFieldController,
        decoration: InputDecoration(
            labelText: 'Поиск',
            border: OutlineInputBorder())),
  );

  _createAdminButton() => MyButton(
        title: "Добавить партнера",
        isEnable: true,
        onPressed: () => {_viewModel.hasToCreateNew.add(true)},
      );

  @override
  PartnerViewModel viewModelInstancer() => PartnerViewModel();

  doLoad() {
    _viewModel.load(_searchFieldController.text, _currentPage, 20, _currentRegion, _currentCity, _currentStatus);
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
              height: 15,
            ),
            _searchWidget(),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              child: RegionAutoTextFieldFixed(
                      (city) {
                        _currentRegion = city;
                    _currentPage = 0;
                    doLoad();
                  }),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              child: CityAutoTextFieldFixed(
                      (city) {
                    _currentCity = city;
                    _currentPage = 0;
                    doLoad();
                  }, onSelectedRegion: () => _currentRegion),
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

  list() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
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
                  doLoad();
                });
          }
          return Container();
        },
      )
    ],
  );
}

class _Desktop extends StatelessWidget {
  final BehaviorSubject<List<PartnerModel>> list;

  const _Desktop(this.list);

  @override
  Widget build(BuildContext context) => Container(
      child: StreamBuilder<List<PartnerModel>>(
        stream: list,
        builder: (context, snapShot) {
          if (snapShot.hasData && snapShot.data != null) {
            return _tables(snapShot.requireData);
          }
          return Center(child: CircularProgressIndicator());
        },
      )
  );

  _tables(List<PartnerModel> data) =>  SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(data.length, (index) => _viewHolder(data[index])),
    )
  );

  _viewHolder(PartnerModel adminModel) => MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: () => ZakazioNavigator.pushWParams(
          "user/profile", {"userID": adminModel.id}),
      child: Card(
          elevation: 4,
          child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UserAvatar(
                              size: 65,
                              user: adminModel,
                            ),
                            VerticalDivider(
                              width: 10,
                              color: Colors.transparent,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${adminModel.firstName} ${adminModel.lastName}\n${adminModel.middleName}",
                                    style: TextStyle(fontSize: 18)),
                                Divider(
                                  color: Colors.transparent,
                                  height: 10,
                                ),
                                buildRichTextHorizontal("Регион", adminModel.city?.region?.name ?? "Не указан"),
                                Divider(
                                  color: Colors.transparent,
                                  height: 10,
                                ),
                                buildRichTextHorizontal("Город", adminModel.city?.name ?? "Не указан"),
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Контакты", style: TextStyle(fontSize: 18)),
                            Divider(
                              color: Colors.transparent,
                              height: 10,
                            ),
                            buildRichTextHorizontal("Телефон", adminModel.phoneNumber),
                            Divider(
                              color: Colors.transparent,
                              height: 10,
                            ),
                            buildRichTextHorizontal("Email", adminModel.email),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Финансы", style: TextStyle(fontSize: 18)),
                            Divider(
                              color: Colors.transparent,
                              height: 10,
                            ),
                            buildRichTextHorizontal("Баланс", formatNumber(adminModel.balance.toInt()) + " руб."),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Заказы", style: TextStyle(fontSize: 18)),
                            Divider(
                              color: Colors.transparent,
                              height: 10,
                            ),
                            buildRichTextHorizontal("Открытые", adminModel.order.count.open.toString()),
                            Divider(
                              color: Colors.transparent,
                              height: 10,
                            ),
                            buildRichTextHorizontal("Завершенные", adminModel.order.count.close.toString())
                          ],
                        )
                      ],
                    ),
                    Divider(
                      height: 15,
                      color: Colors.transparent,
                    ),
                    Container(
                      width: 130,
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: Center(
                        child: Text(
                          adminModel.statusTxt(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              )
          )
      )
    ),
  );

  _tableRow(PartnerModel adminModel) => DataRow(
      cells: [
        DataCell(Text(adminModel.id.toString())),
        DataCell(UserAvatar(
          size: 45,
          user: adminModel,
        )),
        DataCell(Text(
            "${adminModel.firstName} ${adminModel.lastName}\n${adminModel.middleName}")),
        DataCell(Text(adminModel.phoneNumber)),
        DataCell(Text(adminModel.email)),
        DataCell(Text(adminModel.city != null
            ? "${adminModel.city!.region!.name}\n${adminModel.city!.name}"
            : "Не указан")),
        DataCell(Text(
            (adminModel.order.count.open + adminModel.order.count.close)
                .toString(),
            textAlign: TextAlign.end)),
        DataCell(Text(adminModel.balance.toString())),
        DataCell(
            Text(
                adminModel.statusTxt())
        ),
      ],
      onSelectChanged: (_) {
        ZakazioNavigator.pushWParams(
            "user/profile", {"userID": adminModel.id});
      });

}

class _Mobile extends StatelessWidget {
  final BehaviorSubject<List<PartnerModel>> list;

  const _Mobile(this.list);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<PartnerModel>>(
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
            child: _infoCard(e),
            onTap: () => ZakazioNavigator.pushWParams(
                "user/profile", {"userID": e.id})
        )).toList(),
      );
    }
  );

  _infoCard(PartnerModel user) => Card(
    elevation: 4,
    child: Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UserAvatar(user: user, size: 55),
              SizedBox(width: 15),
              Text("${user.firstName} ${user.lastName}\n${user.middleName}")
            ],
          ),
          SizedBox(height: 25),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.mail),
              VerticalDivider(
                width: 10,
                color: Colors.transparent,
              ),
              Text(user.email)
            ],
          ),
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.phone),
              VerticalDivider(
                width: 10,
                color: Colors.transparent,
              ),
              Text(user.phoneNumber)
            ],
          ),
          SizedBox(height: 25),
          Text(
            "Статус по заказам",
            style: TextStyle(fontSize: 18),
          ),
          Divider(
            height: 20,
            color: Colors.transparent,
          ),
          dataInfoField(
              "В процессе", user.order.count.open.toString()),
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          dataInfoField(
              "Завершено", user.order.count.close.toString()),
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          dataInfoField(
              "Отказов", user.order.count.declined.toString()),
        ],
      ),
    ),
  );

}