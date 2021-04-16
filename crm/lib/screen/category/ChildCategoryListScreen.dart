import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/category/CategoryModel.dart';
import 'package:zakazy_crm_v2/model/category/ChildCategoryModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/category/AddCategoryScreen.dart';
import 'package:zakazy_crm_v2/screen/category/AddChildCategory.dart';
import 'package:zakazy_crm_v2/screen/category/CategoryViewModel.dart';
import 'package:zakazy_crm_v2/screen/category/child_category_vm.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';

class ChildCategoryListScreen extends StatefulWidget {
  final int parrentID;

  const ChildCategoryListScreen({Key? key, required this.parrentID})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChildCategoryListScreen(parrentID);
}

class _ChildCategoryListScreen
    extends HomeScreen<ChildCategoryListScreen, ChildCategoryViewModel> {
  final int parentID;

  late ChildCategoryViewModel _viewModel = viewModel();

  _ChildCategoryListScreen(this.parentID);

  @override
  void initState() {
    _viewModel.loadChildList(parentID, 0);
    super.initState();
  }

  @override
  Widget rightDialog() {
    return StreamBuilder<MapEntry<bool, ChildCategoryModel?>>(
      stream: _viewModel.toChildCreateCategory,
      builder: (context, snapShot) {
        if (snapShot.hasData)
          return AddChildCategoryScrees(
              childCategoryModel: snapShot.requireData.value,
              parentID: parentID);
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
          child: _categoryTable(),
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
        title: "Добавить подкатегорию",
        isEnable: true,
        onPressed: () =>
            {_viewModel.toChildCreateCategory.add(MapEntry(true, null))},
      );

  _categoryTable() {
    return Card(
        elevation: 4,
        child: StreamBuilder<PagedListModel<ChildCategoryModel>>(
          stream: _viewModel.childCategoryList,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return _tables(snapShot.requireData);
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  _tables(PagedListModel<ChildCategoryModel> data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: DataTable(
              showBottomBorder: true,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Название',
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
              rows: List<DataRow>.generate(data.content!.length,
                  (index) => _tableRow(data.content![index])),
            ),
          ),
          Divider(
            height: 25,
            color: Colors.transparent,
          ),
          PagesWidget(
              pageLength: data.totalPages,
              currentPage: data.number,
              onSelect: (index) => _viewModel.loadChildList(parentID, index))
        ],
      );

  _tableRow(ChildCategoryModel categoryModel) => DataRow(cells: [
        DataCell(Text(categoryModel.name)),
        DataCell(SmallButton(
            title: "Изменить",
            onPressed: () => {
                  _viewModel.toChildCreateCategory
                      .add(MapEntry(true, categoryModel))
                },
            isEnable: true))
      ]);

  @override
  ChildCategoryViewModel viewModelInstancer() => ChildCategoryViewModel();
}
