// ignore: import_of_legacy_library_into_null_safe
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:js' as js;


import 'package:zakazy_crm_v2/conts.dart';

class OrderFileViewHolde extends StatelessWidget {
  final PlatformFile? file;
  final String? fileName;

  final Function(PlatformFile)? onDelete;
  final Function(String)? onDeleteViaName;
  Function(String)? onDownload;

  OrderFileViewHolde(
      {this.file,
      this.fileName,
      this.onDelete,
      this.onDownload,
      this.onDeleteViaName}) {

    if (onDownload == null && onDelete == null && onDeleteViaName == null) {
      onDownload = (fileName) {
        js.context.callMethod("openInNewTab", [fileUrl(fileName)]);/*
        html.AnchorElement anchorElement = html.AnchorElement();
        anchorElement.href = fileUrl(fileName);
        anchorElement.download = fileName;
        anchorElement.click();*/
      };
    }

  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      onDelete?.call(file!);
      onDeleteViaName?.call(fileName!);
      onDownload?.call(fileName!);
    },
    child: Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            children: [
              Center(
                child: Icon(wallpaper(), size: 50),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    icon: onDelete != null || onDeleteViaName != null
                        ? Icon(Icons.delete)
                        : Icon(Icons.download_rounded),
                    onPressed: () {
                      onDelete?.call(file!);
                      onDeleteViaName?.call(fileName!);
                      onDownload?.call(fileName!);
                    }),
              )
            ],
          ),
        ),
      ),
    ),
  );

  wallpaper() {
    final extension =
        file != null ? file!.extension : fileName!.split(".").last;

    if (["jpg", "jpeg", "png", "svg"].contains(extension))
      return Icons.image;
    else if (["pdf", "doc", "docx", "ppt", "pptx", "txt"].contains(extension))
      return Icons.list_alt_sharp;
    else
      return Icons.file_present;
  }
}
