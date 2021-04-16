// ignore: import_of_legacy_library_into_null_safe
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/unit/FileSelect.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

// ignore: must_be_immutable
class ChangeUserAvatar extends StatefulWidget {
  final String? currentAvatar;
  final double size;

  _ChangeUserAvatarState? _state;

  ChangeUserAvatar({required this.currentAvatar, required this.size});

  @override
  State<StatefulWidget> createState() {
    _state = _ChangeUserAvatarState(size, currentAvatar);

    return _state!;
  }

  PlatformFile? selectedImage() => _state?.selectedFile;
}

class _ChangeUserAvatarState extends State<ChangeUserAvatar> {
  PlatformFile? selectedFile;
  final String? currentAvatar;
  final double size;

  _ChangeUserAvatarState(this.size, this.currentAvatar);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image(),
        Divider(
          height: 10,
          color: Colors.transparent,
        ),
        changeBtn()
      ],
    );
  }

  image() {
    return selectedFile != null
        ? CircleAvatar(
            backgroundImage: MemoryImage(selectedFile!.bytes), radius: size / 2)
        : currentAvatar != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(fileUrl(currentAvatar!)),
                radius: size / 2)
            : Icon(Icons.account_circle, size: this.size, color: primaryColor);
  }

  changeBtn() => FreeButton(
      title: "Изменить", onPressed: () => {selectFile()}, isEnable: true);

  selectFile() async {
    final file = await FileSelect.selectImageFile();
    setState(() {
      this.selectedFile = file;
    });
  }
}
