import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/category/CategoryModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/category/CategoryViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/user/ChangeUserAvatar.dart';

class AddCategoryScreen extends StatefulWidget {
  final CategoryModel? categoryModel;

  const AddCategoryScreen({Key? key, this.categoryModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddCategoryScreenState(categoryModel);
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final CategoryViewModel _viewModel =
      ViewModelProvider<CategoryViewModel>().build(() => CategoryViewModel());

  final _nameTxtController = TextEditingController();

  bool _isLoading = false;

  final rolesToggles = [true, false];

  bool _nameIsEmptyError = false;

  bool _someError = false;

  late ChangeUserAvatar _iconSelect;

  final CategoryModel? categoryModel;

  _AddCategoryScreenState(this.categoryModel) {
    _iconSelect =
        ChangeUserAvatar(currentAvatar: categoryModel?.imageUrl, size: 100);

    if (categoryModel != null) {
      _nameTxtController.text = categoryModel!.name;

      if (categoryModel!.isActive) {
        rolesToggles[0] = true;
        rolesToggles[1] = false;
      } else {
        rolesToggles[0] = false;
        rolesToggles[1] = true;
      }
    }

    _nameTxtController.addListener(() {
      if (_nameIsEmptyError) {
        setState(() {
          _nameIsEmptyError = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Card(
        elevation: 12,
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 48, top: 48),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    categoryModel != null
                        ? "Изменить категорию"
                        : "Создать категорию",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Divider(height: 40, color: Colors.transparent),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _nameTxtController,
                    decoration: InputDecoration(
                        labelText: 'Название',
                        border: OutlineInputBorder(),
                        errorText:
                            (_nameIsEmptyError) ? "Заполните поле" : null),
                    enabled: !_isLoading,
                  ),
                ),
                Divider(height: 30, color: Colors.transparent),
                Text("Статус"),
                Divider(
                  height: 15,
                ),
                _status(),
                Divider(height: 30, color: Colors.transparent),
                Text("Иконка"),
                Divider(height: 15, color: Colors.transparent),
                _iconChangeWidget(),
                Divider(height: 20, color: Colors.transparent),
                (_someError)
                    ? Text(
                        "Не известная ошибка",
                        style: TextStyle(color: Colors.redAccent),
                      )
                    : Container(),
                Divider(height: 10, color: Colors.transparent),
                (_isLoading)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyButton(
                              title: "Сохранить",
                              onPressed: () => _onSaveClick(),
                              isEnable: !_isLoading,
                            ),
                            FreeButton(
                              title: "Отменить",
                              onPressed: () => _onCancelCLick(),
                              isEnable: !_isLoading,
                            )
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _status() => SizedBox(
        width: 300,
        child: ToggleButtons(
          borderRadius: BorderRadius.circular(4.0),
          constraints: BoxConstraints(minHeight: 50.0),
          isSelected: rolesToggles,
          direction: Axis.vertical,
          onPressed: (index) {
            setState(() {
              rolesToggles[0] = false;
              rolesToggles[1] = false;
              rolesToggles[index] = true;
            });
          },
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*Icon(Icons.check_box_outlined),
            VerticalDivider(
              width: 10,
            ),*/
                Text('Включен')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*Icon(Icons.check_box_outline_blank),
            VerticalDivider(
              width: 10,
            ),*/
                Text('Отключен')
              ],
            )
          ],
        ),
      );

  _iconChangeWidget() => _iconSelect;

  _onSaveClick() async {
    final nameTxt = _nameTxtController.text;

    if (nameTxt.isEmpty) {
      setState(() {
        _nameIsEmptyError = true;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _someError = false;
    });

    bool data;

    if (categoryModel == null) {
      data = await _viewModel.add(
          nameTxt, rolesToggles[0], _iconSelect.selectedImage()?.bytes);
    } else {
      data = await _viewModel.edit(categoryModel!.id, nameTxt, rolesToggles[0],
          _iconSelect.selectedImage()?.bytes);
    }

    setState(() {
      _isLoading = false;
      _someError = !data;
    });
  }

  _onCancelCLick() {
    _viewModel.toCreateCategory.add(null);
  }
}
