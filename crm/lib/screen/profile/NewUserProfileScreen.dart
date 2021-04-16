import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/feedback/FeedbackModel.dart';
import 'package:zakazy_crm_v2/model/unit/PagedListModel.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/model/user/partner/PartnerModel.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/pasport/PasportInfoWidget.dart';
import 'package:zakazy_crm_v2/screen/portfolio/ExecutorPortfolioCard.dart';
import 'package:zakazy_crm_v2/screen/portfolio/PortfolioEditScreen.dart';
import 'package:zakazy_crm_v2/screen/portfolio/PortfolioInfoViewScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/UserBalanceCard.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileViewModel.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/BlockActiveUserButton.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/ChangeUserPasswordScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/ExecutorShortInfoCard.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/PartnerExecutorList.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/UserChangePasswordButton.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/UserDataVertificator.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/UserEditInfoScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/UserInfoContactsScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/UserOrderListWidget.dart';
import 'package:zakazy_crm_v2/widget/FeedBackViewHolder.dart';
import 'package:zakazy_crm_v2/widget/PagesWidget.dart';
import 'package:zakazy_crm_v2/widget/payment/AddBalanceAlert.dart';
import 'package:zakazy_crm_v2/widget/payment/UserTransactionList.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';

abstract class NewUserProfileScreen<
T extends StatefulWidget,
USER extends UserInfoModel,
VM extends UserProfileViewModel<USER>> extends HomeScreen<T, VM> {

  @override
  Widget top() => createTitleView("Профиль");

  @override
  Widget rightDialogSized() => StreamBuilder<ToEditData>(
    stream: viewModel().toEditData,
    builder: (context, snapShot) {
      if (!snapShot.hasData) return Container();
      final data = snapShot.requireData;

      if (data.method == ToEditEnum.ADD_PORTFOLIO) {
        print("open edit portfolio");
        return PortfolioEditScreen(data.data, viewModel());
      }
      else if (data.method == ToEditEnum.VIEW_PORTFOLIO) {
        return PortfolioInfoViewScreen(data.data, viewModel());
      }
      else if (data.method == ToEditEnum.EDIT_CONTACTS) {
        return UserEditContactsScreen(data.data, viewModel());
      }

      return Container();
    },
  );

  @override
  Widget rightDialog() => StreamBuilder<ToEditData>(
    stream: viewModel().toEditData,
    builder: (context, snapShot) {
      if (!snapShot.hasData) return Container();
      final data = snapShot.requireData;

      if (data.method == ToEditEnum.EDIT_DATA) {
        return UserEditInfoScreen(data.data, viewModel());
      }
      else if (data.method == ToEditEnum.CHANGE_PASSWORD) {
        return ChangeUserPasswordScreen(data.data, viewModel());
      }
      else if (data.method == ToEditEnum.ADD_BALANCE) {
        return AddBalanceAlert(viewModel());
      }
      else {
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
  Widget body() => Card(
    elevation: 4,
    child: SizedBox(
      width: double.infinity,
      child: StreamBuilder<USER>(
          stream: viewModel().userInfo,
          builder: (_, snapShot) {
            if (!snapShot.hasData) {
              return Center(
                  child: CircularProgressIndicator()
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topData(snapShot.requireData),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                MediaQuery.of(context).size.width > phoneSize
                ? IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoOne(snapShot),
                        VerticalDivider(
                          width: 1,
                          color: Colors.grey,
                        ),
                        Flexible(
                          child: infoTwo(snapShot),
                        )
                      ],
                    )
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    infoOne(snapShot),
                    infoTwo(snapShot)
                  ],
                ),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                orders(snapShot.requireData),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                executorList(snapShot.requireData),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                transactionList(snapShot.requireData),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),

              ],
            );
          }
      )
    )
  );
  
  Widget infoOne(AsyncSnapshot<USER> snapShot) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      contactInfo(snapShot.requireData),
      SizedBox(
        width: 300,
        child: Divider(
          height: 1,
          color: Colors.grey,
        ),
      ),
      balanceInfo(snapShot.requireData),
      SizedBox(
        width: 300,
        child: Divider(
          height: 1,
          color: Colors.grey,
        ),
      ),
      orderStatusOrder(snapShot.requireData),
      SizedBox(
        width: 300,
        child: Divider(
          height: 1,
          color: Colors.grey,
        ),
      ),
      snapShot.requireData.canBeEdit()
          ? SizedBox(width: 300, child: Padding(padding: EdgeInsets.all(24), child: UserChangePasswordButton(
          user: snapShot.requireData,
          onPressed: () => {viewModel().onChangePassword(snapShot.requireData)})))
          : Container(),
      snapShot.requireData.canBlock()
          ? SizedBox(width: 300, child: Padding(padding: EdgeInsets.all(24), child: BlockActiveUserButton(
          user: snapShot.requireData,
          onPressed: () => {viewModel().onBlockUser()})))
          : Container(),
      SizedBox(
        width: 300,
        child: Divider(
          height: 1,
          color: Colors.grey,
        ),
      ),
    ],
  );
  
  Widget infoTwo(AsyncSnapshot<USER> snapShot) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        snapShot.requireData.roleInfo() != RoleType.SUPER_ADMIN
            ? UserDataVertificator(user: snapShot.requireData, viewModel: viewModel())
            : Container(),
        Divider(
          height: 1,
          //width: double.infinity,
          color: Colors.grey,
        ),
        passportInfo(snapShot.requireData),
        Divider(
          height: 1,
          //width: double.infinity,
          color: Colors.grey,
        ),
        portfolio(snapShot.requireData),
        Divider(
          height: 1,
          //width: double.infinity,
          color: Colors.grey,
        ),
        feedbacks(snapShot.requireData)
      ]
  );

  Widget topData(USER user) => Padding(
    padding: EdgeInsets.all(24),
    child: Wrap(
      alignment: WrapAlignment.spaceBetween,
      runAlignment: WrapAlignment.start,
      spacing: 25,
      runSpacing: 25,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserAvatar(user: user, size: 75),
            VerticalDivider(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width > phoneSize ? 300 : 100,
                  child: Text(
                      "${user.firstName} ${user.lastName} ${user.middleName.length > 0 ? user.middleName.substring(0, 1) + "." : ''}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
                Divider(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width > phoneSize ? 300 : 100,
                  child: (user.city != null) ? Text("${user.city!.region!.name}, ${user.city!.name}") : Container(),
                )
              ],
            )
          ],
        ),
        user.canBeEdit() ? FloatingActionButton(
          onPressed: _onEditInfoClick,
          child: Icon(Icons.edit),
        ) : Container()
      ],
    )
  );

  Widget contactInfo(USER user) => SizedBox(
    width: 300,
    child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Контакты",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                )
            ),
            Divider(
              height: 25,
              color: Colors.transparent,
            ),
            dataInfoField("Номер телефона", user.phoneNumber),
            Divider(
              color: Colors.transparent,
              height: 10,
            ),
            dataInfoField("Email", user.email),
            Divider(
              color: Colors.transparent,
              height: 10,
            ),
            Row(
              children: [
                Expanded(child: Container()),
                user.canBeEdit() ? FloatingActionButton(
                  onPressed: _onEditContactClick,
                  child: Icon(Icons.edit),
                ) : Container()
              ],
            )
          ],
        )
    ),
  );

  Widget balanceInfo(USER user) => (user.canBeEdit() &&
      [RoleType.EXECUTOR, RoleType.PARTNER].contains(user.roleInfo()))
      ? UserBalanceCard(viewModel())
      : Container();

  Widget orderStatusOrder(USER user) => user.roleInfo() == RoleType.EXECUTOR
      ? ExecutorShortInfoCard(user as ExecutorModel)
      : Container();

  Widget passportInfo(USER user) => user.pasport != null ? PasportInfoWidget(user.pasport!) : Container();

  Widget portfolio(USER user) => user.roleInfo() == RoleType.EXECUTOR ? ExecutorPortfolioCard(
      executor: user as ExecutorModel, viewModel: viewModel()) : Container();

  Widget feedbacks(USER user) => [RoleType.EXECUTOR, RoleType.CLIENT].contains(user.roleInfo())
      ? SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Отзывы",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Divider(
                  height: 25,
                  color: Colors.transparent,
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
                    }
                )
              ],
            ),
          ))
      : Container();

  Widget orders(USER user) => [RoleType.EXECUTOR, RoleType.CLIENT, RoleType.PARTNER].contains(user.roleInfo())
      ? UserOrderlistWidget(user)
      : Container();

  Widget executorList(USER user) => (user.roleInfo() == RoleType.PARTNER)
      ? SizedBox(
          width: double.infinity,
          child: PartnerExecutorList(user as PartnerModel)
        )
      : Container();

  Widget transactionList(USER user) => ([RoleType.ADMIN, RoleType.SUPER_ADMIN].contains(UserRepository.instance().myUserLiveData.value!.roleInfo()))
      ? SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Транзакции",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Divider(
                  height: 25,
                  color: Colors.transparent,
                ),
                UserTransactionList(
                    data: viewModel().userTransactions,
                    onLoad: viewModel().loadTransaction
                )
              ],
            ),
          )
        )
      : Container();

  _onEditInfoClick() {
    viewModel().openEditInfoDialog(viewModel().userInfo.value!);
  }

  _onEditContactClick() {
    viewModel().openEditContactsDialog(viewModel().userInfo.value!);
  }


}