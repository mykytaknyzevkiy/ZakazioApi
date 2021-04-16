import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/home/DrawerItem.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

class _ZDrawerItem {
  static final dashBoard = _ZDrawerItemType(0, "Dashboard", Icons.analytics,
      List.of({RoleType.ADMIN, RoleType.EDITOR, RoleType.SUPER_ADMIN}));

  static final allOrder = _ZDrawerItemType(
      1,
      "Все заказы",
      Icons.border_all_rounded,
      List.of({RoleType.ADMIN, RoleType.EDITOR, RoleType.SUPER_ADMIN}));

  static final freeOrder = _ZDrawerItemType(1, "Открытые заказы",
      Icons.border_all_rounded, List.of({RoleType.EXECUTOR, RoleType.PARTNER}));

  static final myOrder = _ZDrawerItemType(
      17,
      "Мои заказы",
      Icons.border_all_rounded,
      List.of({RoleType.EXECUTOR, RoleType.PARTNER, RoleType.CLIENT}));

  static final adminUsers = _ZDrawerItemType(
      2, "Админы", Icons.admin_panel_settings, List.of({RoleType.SUPER_ADMIN}));

  static final editorUsers = _ZDrawerItemType(3, "Модераторы", Icons.edit_road,
      List.of({RoleType.SUPER_ADMIN, RoleType.ADMIN}));

  static final partnerUsers = _ZDrawerItemType(
      4,
      "Партнеры",
      Icons.account_balance,
      List.of({RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR}));

  static final executorUsers = _ZDrawerItemType(
      5,
      "Исполнители",
      Icons.handyman_sharp,
      List.of({
        RoleType.SUPER_ADMIN,
        RoleType.ADMIN,
        RoleType.EDITOR,
        RoleType.PARTNER
      }));

  static final clientUser = _ZDrawerItemType(6, "Заказчики", Icons.account_box,
      List.of({RoleType.ADMIN, RoleType.EDITOR, RoleType.SUPER_ADMIN}));

  static final myProfileAction = _ZDrawerItemType(
      12,
      "Мой профиль",
      Icons.account_circle_rounded,
      List.of({
        RoleType.ADMIN,
        RoleType.EDITOR,
        RoleType.SUPER_ADMIN,
        RoleType.PARTNER,
        RoleType.EXECUTOR,
        RoleType.CLIENT
      }));

  static final appsAction = _ZDrawerItemType(
      8,
      "Приложение",
      Icons.touch_app_outlined,
      List.of({
        RoleType.ADMIN,
        RoleType.EDITOR,
        RoleType.SUPER_ADMIN,
        RoleType.PARTNER
      }));

  static final categoryAction = _ZDrawerItemType(9, "Категории", Icons.category,
      List.of({RoleType.ADMIN, RoleType.SUPER_ADMIN}));

  static final addressAction = _ZDrawerItemType(
      10,
      "Адреса",
      Icons.location_on_rounded,
      List.of({RoleType.ADMIN, RoleType.SUPER_ADMIN}));

  static final passportRequestAction = _ZDrawerItemType(
      14,
      "Запросы на паспорт",
      Icons.domain_verification,
      List.of({RoleType.ADMIN, RoleType.EDITOR, RoleType.SUPER_ADMIN}));

  static final importAction = _ZDrawerItemType(15, "Импорт",
      Icons.import_export, List.of({RoleType.SUPER_ADMIN, RoleType.PARTNER}));

  static final myBankCardAction = _ZDrawerItemType(
      16,
      "Мои карты",
      Icons.credit_card_rounded,
      List.of({RoleType.PARTNER, RoleType.EXECUTOR}));

  static final settingsAction = _ZDrawerItemType(
      11, "Настройки", Icons.settings, List.of({RoleType.SUPER_ADMIN}));

  static final postHelpAction = _ZDrawerItemType(18, "Помошь", Icons.help,
      List.of({RoleType.CLIENT, RoleType.EXECUTOR, RoleType.PARTNER}));

  static final listHelpAction = _ZDrawerItemType(
      19,
      "Запросы на помошь",
      Icons.help,
      List.of({
        RoleType.EDITOR,
        RoleType.ADMIN,
        RoleType.SUPER_ADMIN,
        RoleType.PARTNER
      }));

  static final exitAction = _ZDrawerItemType(
      13,
      "Выход",
      Icons.exit_to_app,
      List.of({
        RoleType.ADMIN,
        RoleType.EDITOR,
        RoleType.SUPER_ADMIN,
        RoleType.PARTNER,
        RoleType.EXECUTOR,
        RoleType.CLIENT
      }));

  static final blogAction = _ZDrawerItemType(20, "Блог", Icons.message,
      List.of({RoleType.EDITOR, RoleType.ADMIN, RoleType.SUPER_ADMIN}));

  static final smsAdminAction = _ZDrawerItemType(
      21, "Смс админ", Icons.smartphone_sharp, List.of({RoleType.SUPER_ADMIN}));
}

class ZDrawer extends StatelessWidget {
  final _userRepository = UserRepository.instance();

  final itemsNew = [
    MapEntry("Данные", [
      _ZDrawerItem.myProfileAction,
      _ZDrawerItem.appsAction,
      _ZDrawerItem.myBankCardAction,
    ]),
    MapEntry("Аналитика", [_ZDrawerItem.dashBoard]),
    MapEntry("Заказы",
        [_ZDrawerItem.allOrder, _ZDrawerItem.freeOrder, _ZDrawerItem.myOrder]),
    MapEntry("Пользователи", [
      _ZDrawerItem.adminUsers,
      _ZDrawerItem.editorUsers,
      _ZDrawerItem.partnerUsers,
      _ZDrawerItem.executorUsers,
      _ZDrawerItem.clientUser,
    ]),
    MapEntry("Контент", [
      _ZDrawerItem.categoryAction,
      _ZDrawerItem.addressAction,
      _ZDrawerItem.blogAction
    ]),
    MapEntry("Действия", [
      _ZDrawerItem.passportRequestAction,
      _ZDrawerItem.importAction,
      _ZDrawerItem.settingsAction,
      _ZDrawerItem.smsAdminAction
    ]),
    MapEntry("", [
      _ZDrawerItem.postHelpAction,
      _ZDrawerItem.listHelpAction,
    ]),
    MapEntry("", [_ZDrawerItem.exitAction])
  ];

  List<Widget> _menuList(BuildContext context, int selectedID) {
    final List<Widget> list = List.of({});

    final user = _userRepository.myUserLiveData.value!;

    itemsNew.forEach((element) {
      final menues = List<_ZDrawerItemType>.of({});

      element.value.forEach((zItem) {
        if (MediaQuery.of(context).size.width <= phoneSize &&
            [9, 10, 14, 20, 19, 11, 15, 21].contains(zItem.index)) {
        } else {
          if (zItem.roles.contains(user.roleInfo())) {
            menues.add(zItem);
          }
        }
      });

      if (menues.isNotEmpty) {
        if (MediaQuery.of(context).size.width >= phoneSize) {
          list.add(createGroupeName(element.key));
        } else {
          list.add(Divider(
            height: 15,
            color: Colors.transparent,
          ));
        }

        menues.forEach((menu) {
          list.add(createItem(context, menu, selectedID));
        });
      }
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserInfoModel>(
        stream: _userRepository.myUserLiveData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          return Container(
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (MediaQuery.of(context).size.width >= 500)
                          ? _title()
                          : Container(),
                      (MediaQuery.of(context).size.width >= 500)
                          ? _userData(snapshot.requireData)
                          : Container(),
                      StreamBuilder<ZakazioScreens>(
                          stream: currentScreen,
                          builder: (context, snapShot) {
                            if (snapShot.hasData) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _menuList(
                                    context, snapShot.requireData.drawerID),
                              );
                            }
                            return Container();
                          })
                    ],
                  ),
                ),
                Container(
                  width: 0.5,
                  color: Colors.grey.withAlpha(100),
                )
              ],
            ),
          );
        });
  }

  createGroupeName(String name) => Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
        child: Text(
          name.toUpperCase(),
          style: TextStyle(
              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),
        ),
      );

  createItem(BuildContext context, _ZDrawerItemType itemType, int selectedID) {
    return GestureDetector(
      child: DrawerItem(itemType.title, itemType.icon,
          itemType.index == selectedID, context, phoneSize),
      onTap: () {
        if (itemType.index == 13) {
          _userRepository.exits();
          //currentScreen.add(null);
          return;
        }
        ZakazioNavigator.pushViaDrawer(context, itemType.index);
      },
    );
  }

  _title() => Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 14),
        child: Text(
          appName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      );

  _userData(UserInfoModel user) => Padding(
        padding: EdgeInsets.all(24),
        child: Container(
          constraints: BoxConstraints(maxWidth: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserAvatar(user: user, size: 120),
              Divider(
                height: 15,
                color: Colors.transparent,
              ),
              Text(
                "${user.firstName} ${user.lastName} ${user.middleName}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Divider(
                height: 5,
                color: Colors.transparent,
              ),
              Text(user.roleInfo().name())
            ],
          ),
        ),
      );
}

class _ZDrawerItemType {
  final int index;

  final String title;

  final IconData icon;

  final List<RoleType> roles;

  _ZDrawerItemType(this.index, this.title, this.icon, this.roles);
}
