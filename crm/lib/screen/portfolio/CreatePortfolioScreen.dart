import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/repository/PortfolioRepository.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/ImageSelectSlider.dart';
import 'package:zakazy_crm_v2/widget/ImageSelectWidget.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/screen/portfolio/CreatePortfolioViewModel.dart';

class CreatePortfolioScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreatePortfolioScreenState();
}

class _CreatePortfolioScreenState
    extends HomeScreen<CreatePortfolioScreen, CreatePortfolioViewModel> {
  final _wallpaper = ImageSelectWidget(height: 300);
  final _label = ZTextField(hint: "Заголовок");
  final _imageSlider = ImageSelectSlider();
  final _description = ZTextField(hint: "Описание", isMultiline: true);

  bool _isLoading = false;
  String? error;

  final _portfolioRepository = PortfolioRepository();

  @override
  Widget body() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Обложка", style: TextStyle(fontSize: 18)),
                  Divider(
                    color: Colors.transparent,
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: _wallpaper,
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: _label,
            ),
          ),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Изображении", style: TextStyle(fontSize: 18)),
                  Divider(
                    color: Colors.transparent,
                    height: 15,
                  ),
                  _imageSlider
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: _description,
            ),
          ),
          Divider(
            height: 30,
            color: Colors.transparent,
          ),
          error != null
              ? Text(error!, style: TextStyle(color: Colors.redAccent))
              : Container(),
          Row(
            children: [
              Expanded(child: Container()),
              _isLoading
                  ? CircularProgressIndicator()
                  : FreeButton(
                      title: "Отменить",
                      onPressed: () => _onCancelCLick(),
                      isEnable: true,
                    ),
              !_isLoading
                  ? VerticalDivider(
                      width: 20,
                    )
                  : Container(),
              !_isLoading
                  ? MyButton(
                      title: "Опубликовать",
                      onPressed: () => _onSaveClick(),
                      isEnable: true,
                    )
                  : Container(),
              _isLoading
                  ? VerticalDivider(
                      width: 5,
                    )
                  : Container()
            ],
          ),
          Divider(
            height: 30,
            color: Colors.transparent,
          )
        ],
      );

  _onCancelCLick() {
    ZakazioNavigator.pushViaDrawer(context, 12);
  }

  _onSaveClick() async {
    if (_label.text().isEmpty) {
      _label.setError("Заполните поле");
      return;
    }

    if (_description.text().isEmpty) {
      _description.setError("Заполните поле");
      return;
    }

    if (_wallpaper.image() == null) {
      setState(() {
        error = "Выберите обложку";
      });
      return;
    }

    setState(() {
      error = null;
      _isLoading = true;
    });

    final data = await _portfolioRepository.add(_label.text(),
        _description.text(), _wallpaper.image()!, _imageSlider.images());

    setState(() {
      error = data ? null : "Уэе есть такое портфолио";
      _isLoading = false;
    });

    if (data) {
      _onCancelCLick();
    }
  }

  @override
  int selectedIndex() => 14;

  @override
  Widget top() => Text(
        "Создать портфолио",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
      );

  @override
  viewModelInstancer() => CreatePortfolioViewModel();
}
