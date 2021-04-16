import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/PortfolioModel.dart';
import 'package:zakazy_crm_v2/screen/RightScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileViewModel.dart';
import 'package:zakazy_crm_v2/widget/ImageSelectWidget.dart';
import 'package:zakazy_crm_v2/widget/ImagesSelectingList.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';

class PortfolioEditScreen extends RightScreen {

  final PortfolioModel? id;

  final UserProfileViewModel _viewModel;

  final _titleFiled = ZTextField(hint: "Заголовок", maxLength: 150);
  final _contentField = ZTextField(hint: "Описание", isMultiline: true, maxLength: 500);
  final _wallpaperSelect = ImageSelectWidget(height: 300);
  final _imagesSelecting = ImagesSelectingList();

  late MyButton _saveBtn = MyButton(title: "Сохранить", onPressed: () => _save(), isEnable: true);
  late FreeButton _cancelBtn = FreeButton(title: "Отменить", onPressed: () => {
    _viewModel.toEditData.add(null)
  }, isEnable: true);
  late MyButton _deleteBtn = MyButton(title: "Удалить", onPressed: () => _delete(), isEnable: true, backgroundColor: Colors.redAccent);

  final scrollController = ScrollController();

  final _isLoadingStream = BehaviorSubject<bool>.seeded(false);

  PortfolioEditScreen(this.id, this._viewModel) {
    if (id != null) {
      _titleFiled.setText(id!.label);
      _contentField.setText(id!.description);
      _wallpaperSelect.setCurrentImage(id!.wallpaper);
      _imagesSelecting.setData(id!.imageSlides);
    }
  }

  @override
  Widget body(BuildContext context) => info(context);

  info(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
          (id == null)
              ? "Добавить портфолио"
              : "Изменить порфтволио №${id!.id}",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold)),
      Divider(
        color: Colors.transparent,
        height: 40,
      ),
      SizedBox(
          height: (MediaQuery.of(context).size.height - 230),
          child: Scrollbar(
            controller: scrollController,
            isAlwaysShown: true,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    height: 5,
                    color: Colors.transparent,
                  ),
                  _titleFiled,
                  Divider(
                    height: 15,
                    color: Colors.transparent,
                  ),
                  _wallpaperSelect,
                  _contentField,
                  Divider(
                    height: 15,
                    color: Colors.transparent,
                  ),
                  _imagesSelecting
                ],
              ),
            ),
          )
      ),
      Divider(
        height: 25,
        color: Colors.transparent,
      ),
      SizedBox(
        width: double.infinity,
        child: StreamBuilder(
            stream: _isLoadingStream,
            builder: (_, snapShot) => snapShot.data == true ? Center(child: CircularProgressIndicator()) : _btns(context)
        ),
      )
    ],
  );

  _btns(BuildContext context) => Wrap(
    alignment: WrapAlignment.spaceBetween,
    //spacing: 25,
    runSpacing: 5,
    children: [
      _saveBtn,
      _cancelBtn,
      (id != null) ? _deleteBtn : Container()
    ],
  );

  @override
  double width(BuildContext context) => MediaQuery.of(context).size.width > phoneSize
      ? 550
      : 350;

  _save() async {
    bool isError = false;

    final title = _titleFiled.text();
    final content = _contentField.text();
    final wallpaper = _wallpaperSelect.image();

    if (title.isEmpty) {
      _titleFiled.setError("");
      isError = true;
    }

    if (content.isEmpty) {
      _contentField.setError("");
      isError = true;
    }

    if (wallpaper == null && id == null) {
      _wallpaperSelect.setError("Необходимо выбрать");
      isError = true;
    }

    if (isError) {
      return;
    }

    _isLoadingStream.add(true);

    final images = await _imagesSelecting.images();

    if (id == null) {
      await _viewModel.addPortfolio(title, Base64Codec().encode(wallpaper!.bytes), content, images);
    } else {
      await _viewModel.editPortfolio(id!.id, title, (wallpaper != null) ? Base64Codec().encode(wallpaper.bytes) : null, content, images);
    }

    _isLoadingStream.add(false);
  }

  _delete() async {
    _isLoadingStream.add(true);

    await _viewModel.deletePortfolio(id!.id);

    _isLoadingStream.add(false);
  }

  close() {
    _isLoadingStream.close();
  }

}