// ignore: import_of_legacy_library_into_null_safe
import 'package:file_picker/file_picker.dart';
import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/repository/PasportRepository.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/rest/ActiveUserDaraRest.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileViewModel.dart';
import 'package:zakazy_crm_v2/widget/HelpMessageBubleWidget.dart';

class MyProfileViewModel extends UserProfileViewModel<UserInfoModel> {

  @override
  reloadUser() async {
    await UserRepository.instance().initUser();
    await super.reloadUser();
    final user = userInfo.value!;
    if (user.city == null) {
      helpMessageData.add(HelpMessageBubble("Советуем вам установить адрес работы, чтобы продолжить с нами работать", MapEntry("установить", () => {
        openEditInfoDialog(userInfo.value!)
      })));
    } else if (!user.emailActive && [RoleType.PARTNER, RoleType.EXECUTOR].contains(user.roleInfo())) {
      helpMessageData.add(HelpMessageBubble("Советуем вам подтвердить вашу Email", MapEntry("подтвердить", () => {
        onEmailVertificate()
      })));
    } else if (!user.passportActive && !user.passportInProgress && [RoleType.PARTNER, RoleType.EXECUTOR].contains(user.roleInfo())) {
      helpMessageData.add(HelpMessageBubble("Советуем вам загрузить паспортные данные", MapEntry("загрузить", () => {
        onPasportVerificate()
      })));
    }
  }

  final _userRepository = UserRepository.instance();

  final _pasportRepository = PasportRepository();

  final _activeUserDataRest = ActiveUserData();

  MyProfileViewModel() : super(UserRepository.userID);

  onPhoneVerificate() async {
    final data = await _activeUserDataRest.sendSmsPhone();
    if (data.data == null) return;
    toEditData.add(ToEditData(ToEditEnum.VERTIFY_PHONE, data.data!.token));
  }

  Future<bool> verificatePhone(String token, String code) async {
    isToEditDataLoading.add(true);
    final data = await _activeUserDataRest.checkSmsPhone(token, code);
    isToEditDataLoading.add(false);

    if (data.success) {
      reloadUser();
      toEditData.add(null);
    }

    return data.success;
  }

  onEmailVertificate() async {
    final data = await _activeUserDataRest.sendEmail();
    if (data.data == null) return;
    toEditData.add(ToEditData(ToEditEnum.VERTIFY_EMAIL, data.data!.token));
  }

  Future<bool> verificateEmail(String token, String code) async {
    isToEditDataLoading.add(true);
    final data = await _activeUserDataRest.checkEmail(token, code);
    isToEditDataLoading.add(false);

    if (data.success) {
      reloadUser();
      toEditData.add(null);
    }

    return data.success;
  }

  onPasportVerificate() {
    toEditData.add(ToEditData(ToEditEnum.VERTIFY_PASPORT, null));
  }

  Future<bool> sendPasportInfo(String serial, String number, String dateEx,
      String taxID, PlatformFile firstPage, PlatformFile secoundPage, PlatformFile facePage) async {
    isToEditDataLoading.add(true);
    final data = await _pasportRepository.sendPasportInfo(
        serial, number, dateEx, taxID, firstPage, secoundPage, facePage);
    isToEditDataLoading.add(false);

    if (data) {
      reloadUser();
      toEditData.add(null);
    } else {
      toEditDataError.add("Пользователь с такими паспортными данными уже есть");
    }

    return false;
  }

  editUser(
      UserInfoModel user,
      String firstName,
      String lastName,
      String middleName,
      String email,
      String phoneNumber,
      CityModel? city,
      PlatformFile? avatarFile) async {
    isToEditDataLoading.add(true);

    final data = await _userRepository.edit(
        userID: user.id,
        firstName: (user.firstName == firstName) ? null : firstName,
        lastName: (user.lastName == lastName) ? null : lastName,
        middleName: (user.middleName == middleName) ? null : middleName,
        email: (user.email == email) ? null : email,
        phoneNumber: (user.phoneNumber == phoneNumber) ? null : phoneNumber,
        city: city,
        avatarFile: avatarFile);

    isToEditDataLoading.add(false);

    if (data) {
      reloadUser();
      toEditData.add(null);
    }
  }
}
