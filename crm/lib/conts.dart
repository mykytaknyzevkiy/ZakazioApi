import 'package:flutter/material.dart';

const Color primaryColor = Colors.blue;
const accentColor = Colors.white;

const cardBackgroundColor = Colors.white;

const appName = "Zakazy-CRM V2.72";

const appUrl = "https://api.zakazy.online/api/v1";

const socketUrl = "wss://socket.zakazy.online/out/websocket";

const phoneSize = 500;

//+ch""b>p"s3A_np,n

backgroundImage(BuildContext context) {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage(
        'assets/image/background.jpg',
      ),
      fit: BoxFit.cover,
    ),
  );
}

fileUrl(String? file) {
  if (file == null)
    return "https://cdn1.iconfinder.com/data/icons/condominium-juristic-management-filled-outline/64/resolving_problems-resolving-problems-512.png";
  return "https://file.zakazy.online/" + file;
}

dataInfoField(String label, String txt) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
        Divider(
          color: Colors.transparent,
          height: 5,
        ),
        Text(txt),
      ],
    );

buildRichText(String label, String value) => RichText(
      text: TextSpan(style: TextStyle(color: Colors.black), children: [
        TextSpan(
            text: label + ":",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        TextSpan(text: "\n"),
        TextSpan(text: value, style: TextStyle(fontSize: 12))
      ]),
    );

buildRichTextHorizontal(String label, String value) => RichText(
      text: TextSpan(style: TextStyle(color: Colors.black), children: [
        TextSpan(
            text: label + ": ",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
        TextSpan(
            text: value,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300))
      ]),
    );
