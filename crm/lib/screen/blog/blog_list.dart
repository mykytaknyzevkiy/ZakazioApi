import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/model/blog/blog_model.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/rest/blog_rest.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';
import 'package:zakazy_crm_v2/screen/blog/blog_info.dart';
import 'package:zakazy_crm_v2/screen/blog/blog_vm.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';
import 'package:zakazy_crm_v2/widget/payment/OrderTransactionList.dart';

class BlogListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BlogListState();
}

class _BlogListState extends HomeScreen<BlogListScreen, BlogViewModel> {
  @override
  void initState() {
    viewModel().load(0);
    super.initState();
  }

  @override
  Widget rightDialog() {
    return StreamBuilder<MapEntry<bool, int?>>(
        stream: viewModel().onEdit,
        builder: (_, snapShot) {
          if (snapShot.data?.key == true) {
            return BlogInfoScreen(id: snapShot.data?.value);
          } else
            return Container();
        });
  }

  @override
  Widget body() => StreamBuilder<PagedListModel<BlogModel>>(
      stream: viewModel().list,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final data = snapshot.requireData;
        final list = data.content!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
                elevation: 4,
                child: SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      showCheckboxColumn: false,
                      columns: [
                        BaseColumn("ID"),
                        BaseColumn("Загаловок"),
                        BaseColumn("Дата публикации")
                      ],
                      rows: List.generate(list.length, (index) {
                        final item = list[index];
                        return DataRow(
                            cells: [
                              DataCell(Text(item.id.toString())),
                              DataCell(Text(item.title)),
                              DataCell(Text(item.dateStr()))
                            ],
                            onSelectChanged: (_) {
                              viewModel().onEdit.add(MapEntry(true, item.id));
                            });
                      }),
                    ))),
            Divider(
              height: 25,
              color: Colors.transparent,
            ),
            PagesWidget(
                pageLength: data.totalPages,
                currentPage: data.number,
                onSelect: viewModel().load)
          ],
        );
      });

  @override
  Widget top() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          createTitleView("Блог"),
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          MyButton(title: "Добавить", onPressed: () => {
            viewModel().onEdit.add(MapEntry(true, null))
          }, isEnable: true)
        ],
      );

  @override
  BlogViewModel viewModelInstancer() => BlogViewModel();
}
