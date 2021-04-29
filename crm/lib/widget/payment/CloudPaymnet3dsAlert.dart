import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/payment/CloudPayment3dsModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

class CloudPaymnet3dsAlert extends StatelessWidget {
  static show(
      BuildContext context,
      CloudPayment3dsModel cloudPayment3dsModel,
      int userID,
      int bankID,
      Function() onCLose) {

    js.context.callMethod(
        "open3ds",
        [
          "$appUrl/payment/$userID/cloudpayment/3ds/$bankID",
          cloudPayment3dsModel.transactionId,
          cloudPayment3dsModel.paReq,
          cloudPayment3dsModel.acsUrl
        ]
    );

/*    String dsUrl = "$appUrl/payment/$userID/cloudpayment/3ds/$bankID";
    dsUrl += "?";
    dsUrl += "transactionId=${cloudPayment3dsModel.transactionId}&";
    dsUrl += "paReq=${cloudPayment3dsModel.paReq}&";
    dsUrl += "acsUrl=${cloudPayment3dsModel.acsUrl}";

    html.window.open(dsUrl,"_self");*/

    /*showDialog(
        context: context,
        builder: (_) => Center(
          child: CloudPaymnet3dsAlert(
              cloudPayment3dsModel: cloudPayment3dsModel,
              userID: userID,
              bankID: bankID,
              onCLose: () {
                Navigator.of(context).pop();
                onCLose.call();
              }
          ),
        )
    );*/
  }


  final CloudPayment3dsModel cloudPayment3dsModel;
  final int userID;
  final int bankID;
  final Function() onCLose;


  const CloudPaymnet3dsAlert(
      {
        required this.cloudPayment3dsModel,
        required this.onCLose,
        required this.userID,
        required this.bankID
      });

  @override
  Widget build(BuildContext context) {
    String dsUrl = "$appUrl/payment/$userID/cloudpayment/3ds/$bankID";
    dsUrl += "?";
    dsUrl += "transactionId=${cloudPayment3dsModel.transactionId}&";
    dsUrl += "paReq=${cloudPayment3dsModel.paReq.substring(1, cloudPayment3dsModel.paReq.length)}&";
    dsUrl += "acsUrl=${cloudPayment3dsModel.acsUrl}";

    final viewID = "your-view-id";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        viewID,
            (int id) => html.IFrameElement()
          ..src = dsUrl
          ..style.border = 'none');

    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 300,
                child: HtmlElementView(
                  viewType: viewID,
                ),
              ),
              Divider(
                height: 15,
                color: Colors.transparent,
              ),
              MyButton(
                  title: "Закрыть",
                  onPressed: () => onCLose.call(),
                  isEnable: true
              )
            ],
          ),
        ),
      ),
    );
  }

}