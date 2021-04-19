// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/model/DashBoardAnalyticModel.dart';
import 'package:zakazy_crm_v2/model/dashboard/DashboardModel.dart';
import 'package:zakazy_crm_v2/model/dashboard/ExecutorDashModel.dart';
import 'package:zakazy_crm_v2/rest/DashboardRest.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';

class DashboardViewModel extends ZakazyViewModel {
  final _dashboardRest = DashboardRest();

  final systemDashboard = BehaviorSubject<DashboardModel>.seeded(null);

  final selectedDates = BehaviorSubject<MapEntry<DateType, DateInto?>>.seeded(
      MapEntry(DateType.YEAR, null));

  systemLoad() async {
    systemDashboard.add(null);

    DateInto? dateInto;

    if (selectedDates.value!.key == DateType.CUSTOM) {
      dateInto = selectedDates.value!.value;
    } else if (selectedDates.value!.key == DateType.WEEK) {
      dateInto = DateInto(DateTime.now().add(Duration(days: -7)),
          DateTime.now().add(Duration(days: 1)));
    } else if (selectedDates.value!.key == DateType.MONTH) {
      dateInto = DateInto(
          DateTime(DateTime.now().year, DateTime.now().month, 1),
          DateTime(DateTime.now().year, DateTime.now().month + 1, 1));
    } else if (selectedDates.value!.key == DateType.YEAR) {
      dateInto = DateInto(DateTime(DateTime.now().year, 1, 1),
          DateTime(DateTime.now().year + 1, 1, 1));
    }

    if (dateInto == null) return;

    final data =
        await _dashboardRest.system(dateInto.startStr(), dateInto.endStr());
    systemDashboard.add(data.data);
  }

  setDate(DateType type, DateInto? info) {
    selectedDates.add(MapEntry(type, info));
    systemLoad();
  }

  Future<List<ExecutorDashModel>> executorsTableData() async {
    DateInto? dateInto;

    if (selectedDates.value!.key == DateType.CUSTOM) {
      dateInto = selectedDates.value!.value;
    } else if (selectedDates.value!.key == DateType.WEEK) {
      dateInto =
          DateInto(DateTime.now(), DateTime.now().add(Duration(days: 7)));
    } else if (selectedDates.value!.key == DateType.MONTH) {
      dateInto = DateInto(
          DateTime(DateTime.now().year, DateTime.now().month, 1),
          DateTime(DateTime.now().year, DateTime.now().month + 1, 1));
    } else if (selectedDates.value!.key == DateType.YEAR) {
      dateInto = DateInto(DateTime(DateTime.now().year, 1, 1),
          DateTime(DateTime.now().year + 1, 1, 1));
    }

    final data =
        await _dashboardRest.executors(dateInto!.startStr(), dateInto.endStr());

    return data.data!;
  }

  Future<DashBoardAnalytic> analytic() async {
    DateInto? dateInto;

    if (selectedDates.value!.key == DateType.CUSTOM) {
      dateInto = selectedDates.value!.value;
    } else if (selectedDates.value!.key == DateType.WEEK) {
      dateInto =
          DateInto(DateTime.now(), DateTime.now().add(Duration(days: 7)));
    } else if (selectedDates.value!.key == DateType.MONTH) {
      dateInto = DateInto(
          DateTime(DateTime.now().year, DateTime.now().month, 1),
          DateTime(DateTime.now().year, DateTime.now().month + 1, 1));
    } else if (selectedDates.value!.key == DateType.YEAR) {
      dateInto = DateInto(DateTime(DateTime.now().year, 1, 1),
          DateTime(DateTime.now().year + 1, 1, 1));
    }

    final data = await _dashboardRest.analytic(dateInto!.startStr(), dateInto.endStr());

    return data.data!;
  }

  @override
  close() {
    systemDashboard.close();
    selectedDates.close();
  }
}

enum DateType { WEEK, MONTH, YEAR, CUSTOM }

class DateInto {
  final DateTime start;
  final DateTime end;

  DateInto(this.start, this.end);

  String startStr() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    return formatter.format(start);
  }

  String endStr() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    return formatter.format(end);
  }
}
