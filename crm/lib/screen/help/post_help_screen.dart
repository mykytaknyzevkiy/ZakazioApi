import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/help/post_help_viewmodel.dart';
import 'package:zakazy_crm_v2/unit/FileSelect.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/widget/order/OrderFileViewHolder.dart';

class PostHelpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PostHelpState();
}

class _PostHelpState extends HomeScreen<PostHelpScreen, PostHelpViewModel> {
  late ZTextField _messageTextField = ZTextField(
      hint: "Опишите вашу проблему",
      isMultiline: true,
      onEdit: (txt) {
        _postBtn.setEnable(txt.isNotEmpty);
      });

  late MyButton _postBtn = MyButton(
      title: "Отправить",
      onPressed: () => viewModel()
          .post(_messageTextField.text(), viewModel().selectedFiles.value!),
      isEnable: true);

  @override
  Widget body() => Card(
        elevation: 4,
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: 400),
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: StreamBuilder(
                  stream: viewModel().isLoading,
                  builder: (_, snapSHot) {
                    if (snapSHot.data == true) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return content();
                  })),
        ),
      );

  content() => StreamBuilder(
      stream: viewModel().isDone,
      builder: (_, snapShot) {
        if (snapShot.data == true) {
          return doneWidget();
        }
        return postWidget();
      });

  doneWidget() => Center(
          child: Column(
        children: [
          Text(
            "Ваш запрос принят",
            style: TextStyle(fontSize: 24, color: Colors.green),
          ),
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          Text("Ожидайте ответа от нашего сотрудника")
        ],
      ));

  postWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _messageTextField,
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          StreamBuilder<List<PlatformFile>>(
              stream: viewModel().selectedFiles,
              builder: (context, snapShot) {
                if (snapShot.hasData && snapShot.requireData.isNotEmpty) {
                  final nList = snapShot.requireData;
                  return Wrap(
                      runSpacing: 20,
                      spacing: 20,
                      children: List.generate(
                          nList.length,
                          (index) => OrderFileViewHolde(
                              file: nList[index],
                              onDelete: (file) {
                                final _files = viewModel().selectedFiles.value!;
                                _files.removeAt(index);
                                viewModel().selectedFiles.add(_files);
                              })));
                }
                return Text("Нету файлов");
              }),
          Divider(
            height: 10,
            color: Colors.transparent,
          ),
          FreeButton(
              title: "Добавить", onPressed: () => {_addFile()}, isEnable: true),
          Divider(height: 25, color: Colors.transparent),
          _postBtn
        ],
      );

  _addFile() async {
    final file = await FileSelect.selectFile();

    if (file == null) return;

    final value = viewModel().selectedFiles.value;

    final newValue = List.generate((value.length + 1),
        (index) => (index >= value.length) ? file : value[index]);

    viewModel().selectedFiles.add(newValue);
  }

  @override
  Widget top() => createTitleView("Запросить помошь");

  @override
  PostHelpViewModel viewModelInstancer() => PostHelpViewModel();
}
