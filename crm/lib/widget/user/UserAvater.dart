// ignore: import_of_legacy_library_into_null_safe
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';

class UserAvatar extends StatelessWidget {
  final UserInfoModel user;
  final double size;

  UserAvatar({required this.user, required this.size});

  @override
  Widget build(BuildContext context) {
    return user.avatar != null
        ? CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(fileUrl(user.avatar!), imageRenderMethodForWeb: ImageRenderMethodForWeb.HtmlImage),
            radius: size / 2)
        : Icon(Icons.account_circle, size: this.size, color: primaryColor);
  }
}
