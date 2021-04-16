import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/category/CategoryModel.dart';
import 'package:zakazy_crm_v2/model/category/ChildCategoryModel.dart';
import 'package:zakazy_crm_v2/repository/CategoryRepository.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';

// ignore: must_be_immutable
class CategorySelectWidget extends StatefulWidget {
  _CategorySelectWidgetState? _state;

  @override
  State<StatefulWidget> createState() {
    _state = _CategorySelectWidgetState();

    return _state!;
  }

  selectedCategory() {
    return _state?.selectedCategory();
  }
}

class _CategorySelectWidgetState extends State<CategorySelectWidget> {
  final _categoryRepository = CategoryRepository();

  bool _isError = false;

  CategoryModel? _selectedCity;
  ChildCategoryModel? _selectedChildCategory;

  final _categoryList = BehaviorSubject<List<CategoryModel>>.seeded([]);

  final _childCategoryList =
      BehaviorSubject<List<ChildCategoryModel>>.seeded([]);

  late ZTextField _searchField =
      ZTextField(hint: "Ведите название категории", onEdit: _onSearch);

  _onSearch(String text) async {
    final data = await _categoryRepository.searchActive(text);
    if (text.isNotEmpty) {
      _categoryList.add(data);
    }
  }

  @override
  void initState() {
    _onSearch("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Виберите категорию",
              style: TextStyle(fontSize: 16),
            ),
            Divider(
              height: 30,
              color: Colors.transparent,
            ),
            _searchField,
            Divider(
              height: 30,
              color: Colors.transparent,
            ),
            _data(),
            Divider(
              height: 30,
              color: Colors.transparent,
            ),
            _isError
                ? Text(
                    "Необходимо выбрать категорию",
                    style: TextStyle(color: Colors.redAccent),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  _listData(List<CategoryModel> _list) => Wrap(
        spacing: 20,
        runSpacing: 20,
        children: List.generate(
          _list.length,
          (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCity = _list[index];
                  _isError = false;
                });
              },
              child: buildChild(_list[index])),
        ),
      );

  _data() => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<List<CategoryModel>>(
          stream: _categoryList,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              final list = snapShot.requireData;
              return _listData(list);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      );

  selectedCategory() {
    if (_selectedCity == null) {
      setState(() {
        _isError = true;
      });
    }

    return _selectedCity;
  }

  buildChild(CategoryModel item) {
    final _isSelected = _selectedCity?.id == item.id;
    bool _isHower = false;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Card(
          elevation: 4,
          color: _isSelected
              ? primaryColor.withAlpha(70)
              : _isHower
                  ? primaryColor.withAlpha(50)
                  : Colors.white,
          child: SizedBox(
              width: 150,
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        backgroundImage: NetworkImage(item.imageUrl != null
                            ? fileUrl(item.imageUrl!)
                            : "https://cdn1.iconfinder.com/data/icons/condominium-juristic-management-filled-outline/64/resolving_problems-resolving-problems-512.png"),
                        radius: 35),
                    Divider(height: 20),
                    Text(item.name, textAlign: TextAlign.center)
                  ],
                ),
              ))),
      onHover: (event) => {
        setState(() {
          _isHower = true;
        })
      },
      onExit: (event) => {
        setState(() {
          _isHower = false;
        })
      },
    );
  }

  @override
  void dispose() {
    _categoryList.close();
    _childCategoryList.close();
    super.dispose();
  }
}
