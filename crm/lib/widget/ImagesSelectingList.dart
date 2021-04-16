import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/rest/FileRest.dart';
import 'package:zakazy_crm_v2/unit/FileSelect.dart';

class ImagesSelectingList extends StatelessWidget {
  final _selected = BehaviorSubject<List<dynamic>>.seeded(List.of({}));
  final _fileRest = FileRest();

  @override
  Widget build(BuildContext context) => StreamBuilder<List<dynamic>>(
    stream: _selected,
    builder: (_, snapShot) {
      if (!snapShot.hasData) {
        return Center(child: CircularProgressIndicator());
      }
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 15,
          runSpacing: 5,
          children: List.generate(
              snapShot.requireData.length + 1,
                  (index) => (index == snapShot.requireData.length)
                  ? addImageCard()
                  : imageCard(snapShot.requireData[index])),
        )
      );
    }
  );

  setData(List<String> data) {
    final list = _selected.value!;
    list.addAll(data);
    _selected.add(list);
  }

  addImageCard() => GestureDetector(
    onTap: () async {
      final file = await FileSelect.selectImageFile();
      if (file != null) {
        final list = _selected.value!;
        list.add(file);
        _selected.add(list);
      }
    },
    child: Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            size: 75,
          ),
          Text("Добавить")
        ],
      )
    ),
  );

  imageCard(dynamic image) => SizedBox(
    width: 150,
    height: 150,
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),
            child: Image(
              width: 150,
              height: 150,
              image: imageProvider(image),
              fit: BoxFit.cover,
            )
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
              child: Icon(Icons.delete),
              onPressed: () {
                final list = _selected.value!;
                list.remove(image);
                _selected.add(list);
              }
          ),
        )
      ],
    )
  );

  imageProvider(dynamic image) => ((image is String)
      ? CachedNetworkImageProvider(fileUrl(image), imageRenderMethodForWeb: ImageRenderMethodForWeb.HtmlImage)
      : MemoryImage((image as PlatformFile).bytes!));

  close() {
    _selected.close();
  }

  Future<List<String>> images() async {
    final list = List<String>.of({});

    final files = _selected.value!;

    for (var value in files) {
      if (value is PlatformFile) {
        final url = await _fileRest.uploadFile(Base64Codec().encode(value.bytes), value.extension);
        list.add(url.data!);
      } else if (value is String) {
        list.add(value);
      }
    }

    return list;
  }

}