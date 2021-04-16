import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/blog/blog_vm.dart';
import 'package:zakazy_crm_v2/widget/ImageSelectWidget.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';

class BlogInfoScreen extends StatefulWidget {
  final int? id;

  const BlogInfoScreen({Key? key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BlogInfoState(id);
}

class BlogInfoState extends State<BlogInfoScreen> {
  final BlogViewModel _viewModel =
      ViewModelProvider<BlogViewModel>().build(() => BlogViewModel());

  final int? id;

  final _titleField = ZTextField(hint: "Заголовок", maxLength: 255);
  final _content = ZTextField(hint: "Текст", isMultiline: true);
  final _wallpaperselect = ImageSelectWidget(size: 300);

  bool isEnable = false;

  BlogInfoState(this.id) {
    if (id != null) {
      loadinfo();
    } else {
      isEnable = true;
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Card(
          elevation: 4,
          child: Padding(
              padding: EdgeInsets.all(24),
              child: (isEnable)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            (id == null)
                                ? "Опубликовать блог"
                                : "Изменить блог №$id",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Divider(
                          color: Colors.transparent,
                          height: 40,
                        ),
                        _titleField,
                        Divider(
                          height: 15,
                          color: Colors.transparent,
                        ),
                        Text(
                          "Обложка",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Divider(
                          height: 10,
                          color: Colors.transparent,
                        ),
                        _wallpaperselect,
                        Divider(
                          height: 15,
                          color: Colors.transparent,
                        ),
                        _content,
                        Divider(
                          height: 25,
                          color: Colors.transparent,
                        ),
                        btns(),
                        Divider(
                          height: 15,
                          color: Colors.transparent,
                        ),
                        (id != null)
                            ? MyButton(
                                title: "Удалить",
                                onPressed: () => _viewModel.remove(id!),
                                isEnable: true,
                                backgroundColor: Colors.redAccent,
                              )
                            : Container()
                      ],
                    )
                  : Center(child: CircularProgressIndicator())),
        ),
      );

  btns() => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        MyButton(title: "Сохранить", onPressed: _onSave, isEnable: true),
        FreeButton(
            title: "Отменить",
            onPressed: () => _viewModel.onEdit.add(null),
            isEnable: true)
      ]);

  loadinfo() async {
    final info = await _viewModel.info(id!);

    _titleField.setText(info.title);
    _content.setText(info.content);
    _wallpaperselect.setCurrentImage(info.wallpaper);

    setState(() {
      isEnable = true;
    });
  }

  _onSave() async {
    bool isError = false;

    if (_titleField.text().isEmpty) {
      _titleField.setError("Заполните поле");
      isError = true;
    }
    if (_content.text().isEmpty) {
      _content.setError("Заполните поле");
      isError = true;
    }
    if (_wallpaperselect.currentImage == null &&
        _wallpaperselect.image() == null) {
      _wallpaperselect.setError("Выберите обложку");
      isError = true;
    }

    if (isError) return;

    setState(() {
      isEnable = false;
    });

    if (id != null) {
      await _viewModel.edit(
          id!, _titleField.text(), _content.text(), _wallpaperselect.image());
    } else {
      await _viewModel.save(
          _titleField.text(), _content.text(), _wallpaperselect.image()!);
    }
  }
}
