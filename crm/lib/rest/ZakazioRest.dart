import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';

abstract class ZakazioRest {
  Future<Map<String, dynamic>> post(String path, Map<String, String> headers,
      Map<String, dynamic> body) async {
    headers.addAll({'Content-Type': 'application/json; charset=UTF-8'});

    final userToken = await UserRepository.userToken();

    if (userToken != null) {
      headers.addAll({'Authorization': 'Bearer ' + (userToken)});
    }

    try {
      final http.Response response = await http.post(
        appUrl + path,
        headers: headers,
        body: jsonEncode(body),
      );

      return json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      return {"success": false, "data": null};
    }
  }

  Future<Map<String, dynamic>> put(String path, Map<String, String> headers,
      Map<String, dynamic> body) async {
    headers.addAll({'Content-Type': 'application/json; charset=UTF-8'});

    final userToken = await UserRepository.userToken();

    if (userToken != null) {
      headers.addAll({'Authorization': 'Bearer ' + (userToken)});
    }

    try {
      final http.Response response = await http.put(
        appUrl + path,
        headers: headers,
        body: jsonEncode(body),
      );

      return json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      return {"success": false, "data": null};
    }
  }

  Future<Map<String, dynamic>> get(String path, Map<String, String> headers,
      Map<String, dynamic?> body) async {
    headers.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
    });

    final userToken = await UserRepository.userToken();

    if (userToken != null) {
      headers.addAll({'Authorization': 'Bearer ' + (userToken)});
    }

    if (body.isNotEmpty) {
      path = path + "?";
      int i = 0;
      body.forEach((key, value) {
        path = path + key + "=" + value;

        if (i != body.keys.length - 1) {
          path = path + "&";
        }

        i++;
      });
    }

    try {
      final http.Response response =
          await http.get(appUrl + path, headers: headers);

      return json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      return {"success": false, "data": null};
    }
  }

  Future<Map<String, dynamic>> delete(String path, Map<String, String> headers) async {
    headers.addAll({'Content-Type': 'application/json; charset=UTF-8'});

    final userToken = await UserRepository.userToken();

    if (userToken != null) {
      headers.addAll({'Authorization': 'Bearer ' + (userToken)});
    }

    try {
      final http.Response response = await http.delete(
        appUrl + path,
        headers: headers
      );

      return json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      return {"success": false, "data": null};
    }
  }
}
