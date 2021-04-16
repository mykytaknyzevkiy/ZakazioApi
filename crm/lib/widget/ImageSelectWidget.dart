// ignore: import_of_legacy_library_into_null_safe
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/unit/FileSelect.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

class ImageSelectWidget extends StatelessWidget {
  final BehaviorSubject<PlatformFile> _selectedImage =
      BehaviorSubject.seeded(null);

  final double? size;
  final double? height;

  String? currentImage;

  String? _error;

  ImageSelectWidget({this.size, this.height, this.currentImage});

  @override
  Widget build(BuildContext context) => StreamBuilder<PlatformFile>(
      stream: _selectedImage,
      builder: (_, snapShot) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: size ?? double.infinity,
                  height:
                      height ?? (size ?? MediaQuery.of(context).size.width) / 2,
                  decoration: BoxDecoration(color: Colors.grey),
                  child: snapShot.hasData
                      ? Image(
                          fit: BoxFit.cover,
                          image: MemoryImage(snapShot.requireData.bytes),
                          width: double.infinity,
                          height: height ??
                              (size ?? MediaQuery.of(context).size.width) / 2)
                      : (currentImage != null)
                          ? Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(fileUrl(currentImage)),
                              width: double.infinity,
                              height: height ??
                                  (size ?? MediaQuery.of(context).size.width) /
                                      2)
                          : Container()),
              Divider(
                height: 10,
                color: Colors.transparent,
              ),
              SmallButton(
                  title: "Выбрать", onPressed: selectFile, isEnable: true),
              Divider(
                height: 15,
                color: Colors.transparent,
              ),
              (_error != null)
                  ? Text(
                      _error!,
                      style: TextStyle(color: Colors.redAccent),
                    )
                  : Container()
            ],
          ));

  setCurrentImage(String url) {
    currentImage = url;
    _selectedImage.add(null);
  }

  close() {
    _selectedImage.close();
  }

  selectFile() async {
    final file = await FileSelect.selectImageFile();
    _error = null;
    _selectedImage.add(file);
  }

  setError(String? error) {
    _error = error;
    _selectedImage.add(_selectedImage.value);
  }

  PlatformFile? image() => _selectedImage.value;
}
