import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/category/ChildCategoryModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/category/child_category_vm.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';

class AddChildCategoryScrees extends StatelessWidget {
  final ChildCategoryViewModel _viewModel =
      ViewModelProvider<ChildCategoryViewModel>()
          .build(() => ChildCategoryViewModel());

  final int parentID;
  final ChildCategoryModel? childCategoryModel;

  late ZTextField _nameTxtField =
      ZTextField(hint: "Имя", txt: childCategoryModel?.name);

  AddChildCategoryScrees(
      {Key? key, required this.parentID, this.childCategoryModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Card(
        elevation: 12,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, bottom: 48, top: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  childCategoryModel != null
                      ? "Изменить категорию"
                      : "Создать категорию",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Divider(height: 40, color: Colors.transparent),
              _nameTxtField,
              Divider(height: 15, color: Colors.transparent),
              SizedBox(
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyButton(
                      title: "Сохранить",
                      onPressed: () => _onSaveClick(),
                      isEnable: true,
                    ),
                    FreeButton(
                      title: "Отменить",
                      onPressed: () => _onCancelCLick(),
                      isEnable: true,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ));

  _onSaveClick() async {
    if (_nameTxtField.text().isEmpty) {
      _nameTxtField.setError("Заполните поле");
      return;
    }

    if (childCategoryModel == null) {
      _viewModel.addChild(parentID, _nameTxtField.text());
    } else {
      _viewModel.editChild(
          childCategoryModel!.id, parentID, _nameTxtField.text());
    }
  }

  _onCancelCLick() {
    _viewModel.toChildCreateCategory.add(null);
  }
}
