import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:html';
import 'dart:ui' as ui;
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/MainScreen.dart';
import 'package:zakazy_crm_v2/screen/address/RegionScreen.dart';
import 'package:zakazy_crm_v2/screen/address/city/CityScreen.dart';
import 'package:zakazy_crm_v2/screen/admin/AdminListScreen.dart';
import 'package:zakazy_crm_v2/screen/app/AppListScreen.dart';
import 'package:zakazy_crm_v2/screen/app/info/AppInfoScreen.dart';
import 'package:zakazy_crm_v2/screen/blog/blog_list.dart';
import 'package:zakazy_crm_v2/screen/category/CategoryScreen.dart';
import 'package:zakazy_crm_v2/screen/category/ChildCategoryListScreen.dart';
import 'package:zakazy_crm_v2/screen/client/ClientListScreen.dart';
import 'package:zakazy_crm_v2/screen/create_order/create_order_main.dart';
import 'package:zakazy_crm_v2/screen/dashboard/NewDashboardScreen.dart';
import 'package:zakazy_crm_v2/screen/editor/EditorListScreen.dart';
import 'package:zakazy_crm_v2/screen/executor/ExecutorListScreen.dart';
import 'package:zakazy_crm_v2/screen/help/info/help_request_info.dart';
import 'package:zakazy_crm_v2/screen/help/list/help_list_screen.dart';
import 'package:zakazy_crm_v2/screen/help/post_help_screen.dart';
import 'package:zakazy_crm_v2/screen/import/ImportScreen.dart';
import 'package:zakazy_crm_v2/screen/login/LoginScreen.dart';
import 'package:zakazy_crm_v2/screen/my_bank_card/my_bank_cards_screen.dart';
import 'package:zakazy_crm_v2/screen/order/AllOrderScreen.dart';
import 'package:zakazy_crm_v2/screen/order/MyOrderScreen.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderInfoScreen.dart';
import 'package:zakazy_crm_v2/screen/partner/PartnerListScreen.dart';
import 'package:zakazy_crm_v2/screen/pasport/PasportRequestList.dart';
import 'package:zakazy_crm_v2/screen/portfolio/CreatePortfolioScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/free/FreeProfileScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/my/MyUserProfileScreen.dart';
import 'package:zakazy_crm_v2/screen/settings/SettingsFullScreen.dart';
import 'dart:js' as js;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:zakazy_crm_v2/screen/sms/SmsAdminScreen.dart';
import 'package:zakazy_crm_v2/widget/home/ZDrawer.dart';

final zakazioScreens = [
  ZakazioScreens(route: "login", builder: (_) => LoginScreen(), drawerID: -2),
  ZakazioScreens(route: "main", builder: (_) => MainScreen(), drawerID: 0),
  ZakazioScreens(
      route: "dashboard", builder: (_) => NewDashboardScreen(), drawerID: 0),
  ZakazioScreens(
      route: "order/all", builder: (_) => AllOrderScreen(), drawerID: 1),
  ZakazioScreens(
      route: "order/create", builder: (_) => CreateOrderScreen(), drawerID: 1),
  ZakazioScreens(
      route: "order/info",
      builder: (params) => OrderInfoScreen(orderID: params["id"]),
      drawerID: 1),
  ZakazioScreens(
      route: "user/admin/list", builder: (_) => AdminListScreen(), drawerID: 2),
  ZakazioScreens(
      route: "user/editor/list",
      builder: (_) => EditorListScreen(),
      drawerID: 3),
  ZakazioScreens(
      route: "user/editor/partner",
      builder: (_) => PartnerListScreen(),
      drawerID: 4),
  ZakazioScreens(
      route: "user/executo/partner",
      builder: (_) => ExecutorListScreen(),
      drawerID: 5),
  ZakazioScreens(
      route: "user/client/partner",
      builder: (_) => ClientListScreen(),
      drawerID: 6),
  ZakazioScreens(
      route: "user/profile/my",
      builder: (_) => MyUserProfileScreen(),
      drawerID: 12),
  ZakazioScreens(
      route: "portfolio/add",
      builder: (_) => CreatePortfolioScreen(),
      drawerID: 12),
  ZakazioScreens(
      route: "pasport/request/list",
      builder: (_) => PasportRequestList(),
      drawerID: 14),
  ZakazioScreens(
      route: "region/list", builder: (_) => RegisonScreen(), drawerID: 10),
  ZakazioScreens(
      route: "region/city",
      builder: (params) => CityScreen(regionID: params["id"]),
      drawerID: 10),
  ZakazioScreens(
      route: "category", builder: (_) => CategoryScreen(), drawerID: 9),
  ZakazioScreens(
      route: "category/child",
      builder: (params) => ChildCategoryListScreen(parrentID: params["id"]),
      drawerID: 9),
  ZakazioScreens(
      route: "user/profile",
      builder: (params) => FreeProfileScreen(userID: params["userID"]),
      drawerID: -10),
  ZakazioScreens(
      route: "import", builder: (params) => ImportScreen(), drawerID: 15),
  ZakazioScreens(
      route: "app/list", builder: (_) => AppListScreen(), drawerID: 8),
  ZakazioScreens(
      route: "app/info",
      builder: (params) => AppInfoScreen(appID: params["id"]),
      drawerID: 8),
  ZakazioScreens(
      route: "user/profile/my/bank/list",
      builder: (params) => MyBankCardScreen(
            userID: UserRepository.instance().myUserLiveData.value!.id,
          ),
      drawerID: 16),
  ZakazioScreens(
      route: "order/my", builder: (_) => MyOrderScreen(), drawerID: 17),
  ZakazioScreens(
      route: "help/post", builder: (_) => PostHelpScreen(), drawerID: 18),
  ZakazioScreens(
      route: "help/list", builder: (_) => HelpListScreen(), drawerID: 19),
  ZakazioScreens(
      route: "help/info",
      builder: (params) => HelpRequestInfoScreen(id: params["id"]),
      drawerID: 19),
  ZakazioScreens(
      route: "blog/list",
      builder: (_) => BlogListScreen(),
      drawerID: 20),    
  ZakazioScreens(
      route: "settings",
      builder: (_) => SettingsFullScreen(),
      drawerID: 11),
  ZakazioScreens(
      route: "smsadmin",
      builder: (_) => SmsAdminScreen(),
      drawerID: 21),
];

final BehaviorSubject<ZakazioScreens> currentScreen =
    BehaviorSubject<ZakazioScreens>.seeded(ZakazioScreens(
        route: "user/profile/my",
        builder: (_) => MyUserProfileScreen(),
        drawerID: 12));

class ZakazioScreens {
  final String route;
  final StatefulWidget Function(Map<String, dynamic> params) builder;
  final int drawerID;

  Map<String, dynamic> params = {};

  ZakazioScreens(
      {required this.drawerID, required this.route, required this.builder});

  StatefulWidget screen() {
    /*var uri = Uri.parse(route);
    final params = Map<String, dynamic>();
    params.addAll(uri.queryParameters);*/
    return builder(params);
  }
}

class ZUrlController extends UrlStrategy {
  PlatformLocation _platformLocation = const BrowserPlatformLocation();

  @override
  String getPath() {
    final String path = _platformLocation.pathname + _platformLocation.search;
    return path;
  }

  @override
  Object? getState() {
    return null;
  }

  @override
  Future<void> go(int count) async {
   return;
  }

  @override
  String prepareExternalUrl(String internalUrl) {
    return internalUrl;
  }

  @override
  void pushState(Object? state, String title, String url) {
    _platformLocation.pushState(state, title, url);
  }

  @override
  void replaceState(Object? state, String title, String url) {
    _platformLocation.replaceState(state, title, url);
  }

  @override
  ui.VoidCallback addPopStateListener(html.EventListener fn) {
    _platformLocation.addPopStateListener(fn);
    return () => {};
  }
}

class ZakazioNavigator {

  static final urlController = ZUrlController();

  static final statesScreens = List<ZakazioScreens>.of({});

  static init() async {
    //await urlController.go(0);
    urlController.addPopStateListener((event) {
      final url = urlController.getPath().substring(1, window.location.pathname.toString().length);

      print("popstate $url");

      ZakazioScreens? screen = _findScreen(url);

      if (screen == null) {
        screen = ZakazioScreens(
            route: "user/profile/my",
            builder: (_) => MyUserProfileScreen(),
            drawerID: 12);
      }

      runScreen(screen);
    });

    final url = await js.context.callMethod("currentPath");
    final screen = _findScreen(url);

    if (screen == null) {
      return;
    }

    runScreen(screen);

    return true;
  }

  static runScreen(ZakazioScreens screen) async {
    /*ZDrawerItemType? drawerItem;

    ZDrawer.itemsNew.forEach((element) {
      final list= element.value;
      list.forEach((item) {
        if (item.index == screen.drawerID) {
          drawerItem = item;
        }
      });
    });

    final myUser = UserRepository.instance().myUserLiveData.value;

    if (drawerItem == null)
      return;

    if (!(drawerItem!.roles.contains(myUser.roleInfo()))) {
      return;
    }*/

    final String search = await js.context.callMethod("currentSearch");

    print(search);

    if (search.isNotEmpty) {
      final dataParams = Map<String, dynamic>();

      search.split("&").forEach((element) {
        final data = element.split("=");
        final key = data.first.toString().replaceAll("?", "");
        final value = int.tryParse(data.last) ?? data.last;
        dataParams.addEntries([
          MapEntry(key, value)
        ]);
      });

      print(dataParams);

      screen.params = dataParams;
    }

    statesScreens.add(screen);

    currentScreen.add(screen);
  }

  static open(String url) async {
    //window.history.pushState(null, "Test", url);
    urlController.pushState(1, "Text", url);

    final screen = _findScreen(url);

    if (screen == null)
      return;

    runScreen(screen);
  }

  static push(BuildContext context, String route) {
    open(route);
  }

  static pushWParams(String route, Map<String, dynamic> params) {
    String fullUrl = route + "?";

    params.forEach((key, value) {
      fullUrl += key;
      fullUrl += "=";
      fullUrl += value.toString();
    });

    open(fullUrl);
  }

  static pushViaDrawer(BuildContext context, int drawerID) {
    ZakazioScreens? screen;

    for (int i = 0; i < zakazioScreens.length; i++) {
      final element = zakazioScreens[i];

      if (element.drawerID == drawerID) {
        screen = element;
        break;
      }
    }

    if (screen != null) {
      open(screen.route);
    }
  }

  static back() {
    if (statesScreens.isEmpty)
      return;

    final screen = statesScreens[statesScreens.length - 1];
    statesScreens.removeAt(statesScreens.length - 1);

    currentScreen.add(screen);
  }

  static ZakazioScreens? _findScreen(String route) {
    ZakazioScreens? screen;

    final realPath = route.contains("?") ? route.substring(0, route.indexOf("?")) : route;

    zakazioScreens.forEach((element) {
      if (element.route == realPath) screen = element;
    });

    return screen;
  }
}
