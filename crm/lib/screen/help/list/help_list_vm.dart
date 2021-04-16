import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/model/help/help_request_model.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/help_rest.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';

class HelpListViewModel extends ZakazyViewModel {
  final _helpRest = HelpRest();

  final list = BehaviorSubject<PagedListModel<HelpRequestModel>>();

  load(int pageIdx) async {
    list.add(null);
    
    final data = await _helpRest.list(pageIdx);

    if (data.success) {
      list.add(data.data!);
    } else {
      list.add(PagedListModel(List.empty(), 0));
    }
  }

  @override
  close() {
    list.close();
  }
}
