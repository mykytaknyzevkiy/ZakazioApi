import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/help/help_request_model.dart';
import 'package:zakazy_crm_v2/rest/help_rest.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';
import 'package:zakazy_crm_v2/screen/order/info/OrderClientInfoCard.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/order/OrderFileViewHolder.dart';

class HelpRequestInfoScreen extends StatefulWidget {
  final int id;

  const HelpRequestInfoScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HelpRequestInfoState(id);
}

class _HelpRequestInfoState
    extends HomeScreen<HelpRequestInfoScreen, _ViewModel> {
  final int id;

  _HelpRequestInfoState(this.id);

  @override
  Widget body() => FutureBuilder<HelpRequestModel?>(
      future: viewModel().info(id),
      builder: (_, snapShot) {
        if (!snapShot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapShot.requireData == null) {
          return Center(child: Text("404"));
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              children: [
                OrderClientInfoCard(snapShot.requireData!.user),
                Divider(height: 25, color: Colors.transparent),
                (snapShot.requireData!.status == "CLOSE")
                    ? Container()
                    : buildBtn(snapShot.requireData!)
              ],
            )),
            Expanded(
              flex: 3,
              child: Card(
                  elevation: 4,
                  child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          snapShot.requireData!.statusWidget(),
                          Divider(
                            height: 25,
                            color: Colors.transparent,
                          ),
                          Text(
                            "Сообщение",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Divider(
                            height: 10,
                            color: Colors.transparent,
                          ),
                          Text(
                            snapShot.requireData!.message,
                            style: TextStyle(fontSize: 16),
                          ),
                          Divider(
                            height: 10,
                            color: Colors.transparent,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: List.generate(snapShot.requireData!.files.length,
                                      (index) => OrderFileViewHolde(
                                        fileName: snapShot.requireData!.files[index]
                                      )
                              )
                            )
                          ),
                          Divider(
                            height: 25,
                            color: Colors.transparent,
                          ),
                          Text(snapShot.requireData!.dateStr())
                        ],
                      ))),
            )
          ],
        );
      });

  @override
  Widget top() => createTitleView("Запрос на помошь №$id");

  @override
  _ViewModel viewModelInstancer() => _ViewModel();

  Widget buildBtn(HelpRequestModel item) => MyButton(
      title: (item.status == "OPEN") ? "Начать работу" : "Завершить",
      onPressed: () async {
        if (item.status == "OPEN")
          await viewModel().process(id);
        else
          await viewModel().closeN(id);
        setState(() {

        });
      },
      isEnable: true);
}

class _ViewModel extends ZakazyViewModel {
  final _helpRest = HelpRest();

  Future<HelpRequestModel?> info(int id) async {
    final data = await _helpRest.info(id);

    return data.data;
  }

  process(int id) async {
    await _helpRest.process(id);
  }

  closeN(int id) async {
    await _helpRest.close(id);
  }

  @override
  close() {}
}
