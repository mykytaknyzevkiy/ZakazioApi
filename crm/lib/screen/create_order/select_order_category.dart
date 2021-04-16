import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/category/CategoryModel.dart';
import 'package:zakazy_crm_v2/model/category/ChildCategoryModel.dart';
import 'package:zakazy_crm_v2/model/category/GlobalCategory.dart';
import 'package:zakazy_crm_v2/rest/CategoryRest.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/create_order/create_order_main.dart';
import 'package:zakazy_crm_v2/screen/create_order/create_order_vm.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';

// ignore: must_be_immutable
class SelectOrderCategoryScreen extends CreateOrderStateScreen {
  final _viewModel = ViewModelProvider<CreateOrderNewViewModel>()
      .build(() => CreateOrderNewViewModel());

  late ZTextField _searchField = ZTextField(
      hint: "Поиск", onEdit: (_) => _loadCategoryGlobal());

  final _categoriesList = BehaviorSubject<List<GlobalCategory>>();

  final _categoryRest = CategoryRest();

  final _selectedCategory = BehaviorSubject<ChildCategoryModel>.seeded(null);

  final _isError = BehaviorSubject<bool>.seeded(false);

  SelectOrderCategoryScreen(Function() onNext)
      : super(CreateOrderState.CATEGORY, "Выберите категорию", onNext) {
    _selectedCategory.add(_viewModel.selectedChildCategory);
    _loadCategoryGlobal();
  }

  @override
  nextClick() {
    if (_selectedCategory.value == null) {
      _isError.add(true);
      return;
    }
    _viewModel.selectedChildCategory = _selectedCategory.value;
    super.nextClick();
  }

  _loadCategoryGlobal() async {
    _categoriesList.add(null);

    final data = await _categoryRest.globalSeaarch(_searchField.text());

    if (data.success) {
      _categoriesList.add(data.data);
    } else {}
  }

  @override
  Widget content(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder(
              stream: _isError,
              builder: (_, snapShot) {
                if (snapShot.data == true)
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Необходимо выбрать один из списка",
                          style: TextStyle(color: Colors.redAccent)),
                      Divider(
                        height: 25,
                        color: Colors.transparent,
                      )
                    ],
                  );
                return Container();
              }),
          _searchField,
          Divider(
            height: 25,
          ),
          StreamBuilder<List<GlobalCategory>>(
              stream: _categoriesList,
              builder: (context, snapShot) {
                if (!snapShot.hasData)
                  return Center(child: CircularProgressIndicator());

                final data = snapShot.requireData;

                return StreamBuilder<ChildCategoryModel>(
                    stream: _selectedCategory,
                    builder: (_, nnnn) {
                      return Wrap(
                          spacing: 15,
                          runSpacing: 15,
                          children: List.generate(
                              data.length,
                              (index) =>
                                  buildParentCategory(data[index], nnnn.data)));
                    });
              })
        ],
      );

  buildParentCategory(
          GlobalCategory globalCategory, ChildCategoryModel? selected) =>
      Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: 225,
            height: 300,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              buildParentHead(globalCategory.parent),
              SizedBox(
                height: 16,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: (globalCategory.childList.length > 5)
                      ? 5
                      : globalCategory.childList.length,
                  itemBuilder: (_, index) => buildChild(
                      globalCategory.childList[index],
                      globalCategory.childList[index].id == selected?.id)),
              SizedBox(
                height: 16,
              ),
              (globalCategory.childList.length > 5)
                  ? MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => {},
                        child: Text(
                          "Еще",
                          style: TextStyle(fontSize: 16, color: primaryColor),
                        ),
                      ),
                    )
                  : Container()
            ]),
          ),
        ),
      );

  buildParentHead(CategoryModel parent) => Row(children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(parent.imageUrl != null
              ? fileUrl(parent.imageUrl!)
              : "https://cdn1.iconfinder.com/data/icons/condominium-juristic-management-filled-outline/64/resolving_problems-resolving-problems-512.png"),
        ),
        VerticalDivider(
          width: 10,
          color: Colors.transparent,
        ),
        Text(
          parent.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ]);

  buildChild(ChildCategoryModel child, bool isSelected) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SmallButton(
        elevation: 0,
        title: child.name,
        onPressed: () {
          _selectedCategory.add(child);
          if (_isError.value == true) _isError.add(false);
        },
        isEnable: true,
        backgroundColor: isSelected ? null : Colors.white,
        foregroundColor: isSelected ? null : Colors.black,
      ));

  close() {
    _categoriesList.close();
    _selectedCategory.close();
    _isError.close();
  }
}
