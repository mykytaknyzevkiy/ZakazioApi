// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_slider/carousel_slider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/unit/FileSelect.dart';

// ignore: must_be_immutable
class ImageSelectSlider extends StatefulWidget {
  _ImageSelectSliderState? _state;
  @override
  State<StatefulWidget> createState() {
    _state = _ImageSelectSliderState();

    return _state!;
  }

  List<PlatformFile> images() => _state!.images;
}

class _ImageSelectSliderState extends State<ImageSelectSlider> {
  final images = List<PlatformFile>.of({});

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.bottomRight,
        children: [
          CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (BuildContext context, int itemIndex, realIndex) {
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Image(
                        fit: BoxFit.cover,
                        image: MemoryImage(images[itemIndex].bytes),
                        width: MediaQuery.of(context).size.width),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        child: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            images.removeAt(itemIndex);
                          });
                        },
                      ),
                    )
                  ],
                );
              },
              options: CarouselOptions(
                enableInfiniteScroll: false,
                height: 300,
                enlargeCenterPage: true,
              )),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => selectImage(),
            ),
          )
        ],
      );

  selectImage() async {
    final image = await FileSelect.selectImageFile();
    if (image != null) {
      setState(() {
        images.add(image);
      });
    }
  }
}
