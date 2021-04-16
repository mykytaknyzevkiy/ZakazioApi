// ignore: import_of_legacy_library_into_null_safe
import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:file_picker/file_picker.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/rxdart.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zakazy_crm_v2/factor/UserFactor.dart';
import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/notificattion_service.dart';
import 'package:zakazy_crm_v2/rest/UserRest.dart';
import 'package:zakazy_crm_v2/screen/profile/my/MyUserProfileScreen.dart';
import 'package:zakazy_crm_v2/screens.dart';

class UserRepository {
  static String? gcmToken;

  static UserRepository? _instance;

  static int userID = -1;

  static final BehaviorSubject<UserInfoModel> myUserLiveDataN = BehaviorSubject.seeded(null);

  static UserRepository instance() {
    if (_instance == null) {
      _instance = UserRepository();
    }

    return _instance ?? UserRepository();
  }

  static Future<String?> userToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("user_token")) return null;

    return prefs.getString("user_token");
  }

  final _userRest = UserRest();

  final BehaviorSubject<UserInfoModel> myUserLiveData = myUserLiveDataN;

  /*initFirebase() async {
    await Firebase.initializeApp();
    final messaging = FirebaseMessaging.instance;
    gcmToken = await messaging.getToken(
      vapidKey:
          "BDnsKmdD0ouiYjEiUJku2UdPTkM-uzCIJfU4Mq54npG-vLmtPJv7K1I5hM9VsLtTBgAMe0L6K-U5Lj3QXopSpvw",
    );
    print("Firebase token is $gcmToken");
    return 1;
  }*/

  Future<bool> initUser() async {
    final userTokenN = await userToken() ?? '';

    if (userTokenN.isEmpty) return false;

    try {
      final json = await _userRest.myData();

      final bool isSuccess = json["success"];

      if (isSuccess) {
        final user = UserFactor().build(json["data"]);

        userID = user.id;

        myUserLiveData.add(user);

        NotoficationService().start();
      }

      return isSuccess;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    final data = await _userRest.login(email: email, password: password);

    if (data.success && data.data != null) {
      final nToken = data.data?.token;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("user_token", nToken);
    }

    return data.success;
  }

  exits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user_token", null);
    myUserLiveData.add(null);
    currentScreen.add(ZakazioScreens(
        route: "user/profile/my",
        builder: (_) => MyUserProfileScreen(),
        drawerID: 12));
  }

  Future<String?> registerStep1(String email, RoleType roleType) async {
    final tokenModel = await _userRest.registerStep1(email, roleType);

    if (tokenModel.data != null) {
      return tokenModel.data?.token;
    } else {
      return null;
    }
  }

  Future<String?> registerStep2(String code, String token, RoleType roleType) async {
    final tokenModel =
        await _userRest.registerStep2(code, token, roleType);

    return tokenModel.data != null ? tokenModel.data?.token : null;
  }

  Future<bool> registerStep3(
      String token,
      String firstName,
      String lastName,
      String middleName,
      String phoneNumber,
      String password,
      RoleType roleType) async {
    final data = await _userRest.registerStep3(
        token, firstName, lastName, middleName, phoneNumber, password, roleType);

    if (data.data == null) return false;

    if (data.success) {
      final nToken = data.data?.token;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("user_token", nToken);
    }

    return data.success;
  }

  Future<bool> edit(
      {required int userID,
      String? firstName,
      String? lastName,
      String? middleName,
      String? email,
      String? phoneNumber,
      CityModel? city,
      PlatformFile? avatarFile}) async {
    final data = await _userRest.editUser(
        userID: userID,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        email: email,
        phoneNumber: phoneNumber,
        cityID: city?.id,
        avatarBase64:
            avatarFile == null ? null : base64.encode(avatarFile.bytes));

    return data.success;
  }

  Future<bool> changeUserPassword(
      {required int userID, required String newPasspord}) async {
    final data = await _userRest.changeUserPassword(
        userID: userID, newPasspord: newPasspord);

    return data.success;
  }

  Future<UserInfoModel> userInfo(int userID) async {
    final json = await _userRest.userInfo(userID);

    return UserFactor().build(json);
  }
}
