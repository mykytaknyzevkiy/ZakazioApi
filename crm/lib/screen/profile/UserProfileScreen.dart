import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/feedback/FeedbackModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/model/user/partner/PartnerModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/pasport/PasportInfoWidget.dart';
import 'package:zakazy_crm_v2/screen/portfolio/ExecutorPortfolioCard.dart';
import 'package:zakazy_crm_v2/screen/portfolio/PortfolioEditScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/UserBalanceCard.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileViewModel.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/BlockActiveUserButton.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/ChangeUserPasswordScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/ExecutorShortInfoCard.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/PartnerExecutorList.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/UserChangePasswordButton.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/UserDataVertificator.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/UserEditInfoScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/UserInfoCard.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/UserOrderListWidget.dart';
import 'package:zakazy_crm_v2/widget/FeedBackViewHolder.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';
import 'package:zakazy_crm_v2/widget/payment/AddBalanceAlert.dart';

abstract class UserProfileScreen<
    T extends StatefulWidget,
    USER extends UserInfoModel,
    VM extends UserProfileViewModel<USER>> extends HomeScreen<T, VM> {
  @override
  Widget rightDialog() => StreamBuilder<ToEditData>(
        stream: viewModel().toEditData,
        builder: (context, snapShot) {
          if (!snapShot.hasData) return Container();
          final data = snapShot.requireData;

          print(data.method);

          if (data.method == ToEditEnum.EDIT_DATA) {
            return UserEditInfoScreen(data.data, viewModel());
          } else if (data.method == ToEditEnum.CHANGE_PASSWORD) {
            return ChangeUserPasswordScreen(data.data, viewModel());
          } else if (data.method == ToEditEnum.ADD_BALANCE) {
            return AddBalanceAlert(viewModel());
          } else {
            print("else right screen");
            return findExRightDialog(data);
          }
        },
      );

  Widget findExRightDialog(ToEditData data);

  @override
  void initState() {
    viewModel().loadFeedbacks(0);
    super.initState();
  }

  @override
  Widget body() {
    return StreamBuilder<USER>(
      stream: viewModel().userInfo,
      builder: (context, snapShot) {
        if (!snapShot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final user = snapShot.requireData;

        if (MediaQuery.of(context).size.width >= phoneSize)
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              leftSide(user),
              Flexible(
                child: rightSide(user),
              )
            ],
          );
        else
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [leftSide(user), rightSide(user)],
          );
      },
    );
  }

  leftSide(USER user) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfoCard(user, () => viewModel().openEditInfoDialog(user), null),
          user.canBeEdit()
              ? UserChangePasswordButton(
                  user: user,
                  onPressed: () => {viewModel().onChangePassword(user)})
              : Container(),
          user.canBlock()
              ? BlockActiveUserButton(
                  user: user, onPressed: () => {viewModel().onBlockUser()})
              : Container(),
          user.roleInfo() == RoleType.EXECUTOR
              ? ExecutorShortInfoCard(user as ExecutorModel)
              : Container(),
          user.roleInfo() == RoleType.EXECUTOR ||
                  user.roleInfo() == RoleType.PARTNER ||
                  user.roleInfo() == RoleType.SUPER_ADMIN
              ? UserBalanceCard(viewModel())
              : Container(),
        ],
      );

  rightSide(USER user) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: UserDataVertificator(user: user, viewModel: viewModel()),
          ),
          SizedBox(
            width: double.infinity,
            child: (user.pasport != null && user.roleInfo() != RoleType.CLIENT)
                ? PasportInfoWidget(user.pasport!)
                : Container(),
          ),
          SizedBox(
            width: double.infinity,
            child: user.roleInfo() == RoleType.EXECUTOR
                ? ExecutorPortfolioCard(
                    executor: user as ExecutorModel, viewModel: viewModel())
                : Container(),
          ),
          SizedBox(
            width: double.infinity,
            child: (user.roleInfo() == RoleType.EXECUTOR ||
                    user.roleInfo() == RoleType.CLIENT ||
                    user.roleInfo() == RoleType.PARTNER)
                ? UserOrderlistWidget(user)
                : Container(),
          ),
          SizedBox(
              width: double.infinity,
              child: (user.roleInfo() == RoleType.PARTNER)
                  ? PartnerExecutorList(user as PartnerModel)
                  : Container()),
          (user.roleInfo() == RoleType.CLIENT ||
                  user.roleInfo() == RoleType.EXECUTOR)
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 12,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Отзывы",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Divider(
                            color: Colors.transparent,
                            height: 40,
                          ),
                          StreamBuilder<PagedListModel<FeedbackModel>>(
                              stream: viewModel().feedBacks,
                              builder: (context, snapShot) {
                                if (!snapShot.hasData)
                                  return Center(
                                      child: CircularProgressIndicator());
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: List.generate(
                                          snapShot.requireData.content!.length,
                                          (index) => FeedBackViewHolder(snapShot
                                              .requireData.content![index])),
                                    ),
                                    Divider(
                                        height: 20, color: Colors.transparent),
                                    PagesWidget(
                                        pageLength:
                                            snapShot.requireData.totalPages,
                                        currentPage:
                                            snapShot.requireData.number,
                                        onSelect: (index) {
                                          viewModel().loadFeedbacks(index);
                                        })
                                  ],
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: exChilds())
        ],
      );

  List<Widget> exChilds();

  @override
  Widget top() => Container();
}
