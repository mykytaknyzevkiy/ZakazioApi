// ignore: import_of_legacy_library_into_null_safe
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/model/PortfolioModel.dart';
import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/model/feedback/FeedbackModel.dart';
import 'package:zakazy_crm_v2/model/transaction/TransactionModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/repository/PaymentRepository.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/rest/FeedbackRest.dart';
import 'package:zakazy_crm_v2/rest/FileRest.dart';
import 'package:zakazy_crm_v2/rest/PaymentRest.dart';
import 'package:zakazy_crm_v2/rest/PortfolioRest.dart';
import 'package:zakazy_crm_v2/rest/UserRest.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';
import 'package:zakazy_crm_v2/widget/payment/CloudPaymnet3dsAlert.dart';

abstract class UserProfileViewModel<USER extends UserInfoModel> extends ZakazyViewModel {
  final int userID;

  final _userRepository = UserRepository.instance();

  final _paymentRepository = PaymentRepository();

  final _feedbackRest = FeedbackRest();

  final _paymentRest = PaymentRest();

  final _fileRest = FileRest();

  final _porfolioRest = PortfolioRest();

  final BehaviorSubject<ToEditData> toEditData = BehaviorSubject.seeded(null);

  final BehaviorSubject<bool> isToEditDataLoading =
      BehaviorSubject.seeded(false);

  final BehaviorSubject<String> toEditDataError = BehaviorSubject.seeded(null);

  final BehaviorSubject<USER> userInfo = BehaviorSubject.seeded(null);

  final feedBacks = BehaviorSubject<PagedListModel<FeedbackModel>>();

  final userTransactions = BehaviorSubject<PagedListModel<TransactionModelImp>>();

  UserProfileViewModel(this.userID) {
    reloadUser();
  }

  loadTransaction(int pageIndex) async {
    userTransactions.add(null);

    final data = await _paymentRest.userList(userID, pageIndex);

    if (data.success) {
      userTransactions.add(data.data);
    } else {
      userTransactions.add(PagedListModel(List.empty(), 0));
    }
  }

  loadFeedbacks(int pageNum) async {
    feedBacks.add(null);

    final data = await _feedbackRest.user(userID);

    if (data.success) {
      feedBacks.add(data.data!);
    } else {
      feedBacks.add(PagedListModel(List.empty(), 0));
    }
  }

  reloadUser() async {
    userInfo.add(null);
    
    final data = await _userRepository.userInfo(userID);

    userInfo.add(data as USER);
  }

  //OPEN DIALOGS//
  openEditInfoDialog(UserInfoModel user) {
    toEditData.add(ToEditData(ToEditEnum.EDIT_DATA, user));
  }

  openEditContactsDialog(UserInfoModel user) {
    toEditData.add(ToEditData(ToEditEnum.EDIT_CONTACTS, user));
  }


  onChangePassword(UserInfoModel user) {
    toEditData.add(ToEditData(ToEditEnum.CHANGE_PASSWORD, user));
  }

  onBlockUser() async {
    await UserRest().blockUser(userID: userInfo.value!.id);
    reloadUser();
  }

  //OPEN DIALOGS//

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

  Future<bool> changePasspord(
      {required UserInfoModel user, required String newPasspord}) async {
    isToEditDataLoading.add(true);
    final data = await _userRepository.changeUserPassword(
        userID: user.id, newPasspord: newPasspord);
    isToEditDataLoading.add(false);

    if (data) {
      reloadUser();
      toEditData.add(null);
    }

    return data;
  }

  Future<double> balance() async {
    final data = await _paymentRepository.userBalance(userID);
    return data;
  }

  onOutBalance() {
    toEditData.add(ToEditData(ToEditEnum.OUT_BALANCE, null));
  }

  onAddBalance() {
    toEditData.add(ToEditData(ToEditEnum.ADD_BALANCE, null));
  }

  addBalance(BuildContext context, int amount, int cardID) async {
    isToEditDataLoading.add(true);

    final data = await _paymentRepository.paymentRest.addBalance(userID, amount, cardID);

    if (data.success && data.data == null) {
      reloadUser();
      toEditData.add(null);
      isToEditDataLoading.add(false);
    } else if (!data.success) {
      toEditDataError.add("Ошибка трансакции, обратитесь в банк");
      isToEditDataLoading.add(false);
    }
    else {
      /*CloudPaymnet3dsAlert.show(
          context,
          data.data!,
          userID,
          cardID, () {
        reloadUser();
        toEditData.add(null);
        isToEditDataLoading.add(false);
      });*/
    }
  }

  outBalance(double amount, int cardID) async {
    isToEditDataLoading.add(true);

    final data = await _paymentRepository.paymentRest.outSum(cardID, amount);

    if (data.success) {
      reloadUser();
      toEditData.add(null);
      isToEditDataLoading.add(false);
    } else {
      toEditDataError.add("Ошибка трансакции, обратитесь в банк");
      isToEditDataLoading.add(false);
    }
  }

  onAddPortfolio() {
    toEditData.add(ToEditData(ToEditEnum.ADD_PORTFOLIO, null));
  }

  onEditPortfolio(PortfolioModel id) {
    toEditData.add(ToEditData(ToEditEnum.ADD_PORTFOLIO, id));
  }

  addPortfolio(
      String title,
      String wallpaper64,
      String content,
      List<String> imageUrls) async {
    final wallpaperUrl = (await _fileRest.uploadFile(wallpaper64, "jpg")).data!;

    await _porfolioRest.add(title, content, wallpaperUrl, imageUrls);

    await reloadUser();

    toEditData.add(null);
  }

  editPortfolio(
      int id,
      String title,
      String? wallpaper64,
      String content,
      List<String> imageUrls) async {
    final wallpaperUrl = (wallpaper64 != null) ? (await _fileRest.uploadFile(wallpaper64, "jpg")).data! : null;

    await _porfolioRest.edit(id, title, content, wallpaperUrl, imageUrls);

    await reloadUser();

    toEditData.add(null);
  }

  deletePortfolio(int id) async {
    final data = await _porfolioRest.remove(id);

    await reloadUser();

    toEditData.add(null);
  }

  Future<PortfolioModel> portfolioInfo(int id) async {
    final data = await _porfolioRest.info(id);
    return data.data!;
  }

  viewPortfolio(PortfolioModel portfolioModel) {
    toEditData.add(ToEditData(ToEditEnum.VIEW_PORTFOLIO, portfolioModel));
  }

  close() {
    toEditData.close();
    isToEditDataLoading.close();
    toEditDataError.close();
    feedBacks.close();
    userTransactions.close();
  }
}

enum ToEditEnum {
  EDIT_DATA,
  EDIT_INFO,
  EDIT_CONTACTS,
  VERTIFY_PHONE,
  VERTIFY_EMAIL,
  VERTIFY_PASPORT,
  ADD_PORTFOLIO,
  CHANGE_PASSWORD,
  ADD_BALANCE,
  OUT_BALANCE,
  VIEW_PORTFOLIO
}

class ToEditData {
  final ToEditEnum method;
  final dynamic? data;

  ToEditData(this.method, this.data);
}
