// ignore: import_of_legacy_library_into_null_safe
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/pasport/PasportModel.dart';
import 'dart:html' as html;


class PasportInfoWidget extends StatelessWidget {
  final PasportModel _pasport;

  const PasportInfoWidget(this._pasport);


  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Паспорт",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Divider(
            height: 25,
            color: Colors.transparent,
          ),
          SizedBox(
            width: double.infinity,
            child: info(),
          ),
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          SizedBox(
            width: double.infinity,
            child: files(),
          )
        ],
      ),
    ),
  );

  info() => Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 25,
        //spacing: 25,
        children: [
          buildRichText("Серия", _pasport.serial),
          buildRichText("Номер", _pasport.number),
          buildRichText("Дата", _pasport.dateBegin),
          buildRichText("ИНН", _pasport.taxID)
        ],
      );

  files() => Wrap(
    alignment: WrapAlignment.spaceBetween,
    children: List.generate(
        _pasport.files.length,
            (index) => Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(0),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(Icons.file_present, size: 50),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            icon: Icon(Icons.open_in_new),
                            onPressed: () {
                              html.AnchorElement anchorElement = html.AnchorElement();
                              anchorElement.href = fileUrl(_pasport.files[index]);
                              anchorElement.download = _pasport.files[index];
                              anchorElement.click();
                            }),
                      )
                    ],
                  ),
                ),
              ),
            )
    ),
  );
}
