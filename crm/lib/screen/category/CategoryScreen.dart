import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/category/CategoryModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/category/AddCategoryScreen.dart';
import 'package:zakazy_crm_v2/screen/category/CategoryViewModel.dart';
import 'package:zakazy_crm_v2/screen/category/category_view_holder.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState
    extends HomeScreen<CategoryScreen, CategoryViewModel> {
  late CategoryViewModel _viewModel = viewModel();

  @override
  Widget rightDialog() {
    return StreamBuilder<MapEntry<bool, CategoryModel?>>(
      stream: _viewModel.toCreateCategory,
      builder: (context, snapShot) {
        if (snapShot.hasData)
          return AddCategoryScreen(categoryModel: snapShot.requireData.value);
        else
          return Container();
      },
    );
  }

  @override
  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        _createCategoryButton(),
        Divider(height: 50, color: Colors.transparent),
        SizedBox(
          width: double.infinity,
          child: MediaQuery.of(context).size.width > phoneSize
            ? _Desktop(_viewModel.categoryList, (categoryModel) {
            _viewModel.toCreateCategory
                .add(MapEntry(true, categoryModel));
          })
              : _Mobile(_viewModel.categoryList, (categoryModel) {
            _viewModel.toCreateCategory
                .add(MapEntry(true, categoryModel));
          })
        )
      ],
    );
  }

  @override
  int selectedIndex() => 9;

  @override
  Widget top() {
    return Text(
      "Категория",
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
    );
  }

  _createCategoryButton() => MyButton(
        title: "Создать категорию",
        isEnable: true,
        onPressed: () =>
            {_viewModel.toCreateCategory.add(MapEntry(true, null))},
      );

  @override
  CategoryViewModel viewModelInstancer() => CategoryViewModel();
}

class _Desktop extends StatelessWidget {
  final BehaviorSubject<List<CategoryModel>> _categoryList;
  final Function(CategoryModel) _onEdit;

  const _Desktop(this._categoryList, this._onEdit);

  @override
  Widget build(BuildContext context) => Card(
      elevation: 4,
      child: StreamBuilder(
        stream: _categoryList,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return _tables(snapShot.requireData as List<CategoryModel>);
          }
          return Center(child: CircularProgressIndicator());
        },
      ));

  _tables(List<CategoryModel> data) {
    return DataTable(
      showBottomBorder: true,
      showCheckboxColumn: false,
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Иконка',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Название',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Статус',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Действие',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: List<DataRow>.generate(
          data.length, (index) => _tableRow(data[index])),
    );
  }

  _tableRow(CategoryModel categoryModel) => DataRow(
      cells: [
        DataCell(Image(
          width: 60,
          image: NetworkImage(categoryModel.imageUrl != null
              ? fileUrl(categoryModel.imageUrl!)
              : "https://cdn1.iconfinder.com/data/icons/condominium-juristic-management-filled-outline/64/resolving_problems-resolving-problems-512.png"),
        )),
        DataCell(Text(categoryModel.name)),
        DataCell(Text(categoryModel.isActive ? 'Включен' : 'Отключен')),
        DataCell(SmallButton(
            title: "Изменить",
            onPressed: () => {
              _onEdit(categoryModel)
            },
            isEnable: true))
      ],
      onSelectChanged: (_) {
        ZakazioNavigator.pushWParams(
            "category/child", {"id": categoryModel.id});
      });
}

class _Mobile extends StatelessWidget {
  final BehaviorSubject<List<CategoryModel>> _categoryList;
  final Function(CategoryModel) _onEdit;

  const _Mobile(this._categoryList, this._onEdit);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<CategoryModel>>(
    stream: _categoryList,
    builder: (context, snapShot) {
      if (snapShot.hasData) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: snapShot.requireData.map((e) => GestureDetector(
              child: CategoryViewHolder(e, _onEdit),
              onTap: () => ZakazioNavigator.pushWParams(
                  "category/child", {"id": e.id})
          )).toList(),
        );
      }
      return Center(child: CircularProgressIndicator());
    },
  );

}