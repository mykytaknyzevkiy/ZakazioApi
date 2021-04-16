import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/screen/register/card/RegisterCardWizard.dart';

// ignore: must_be_immutable
class RegisterRoleCard extends RegisterCardWizard {
  RegisterRoleCard(Function() toNextPage) : super(toNextPage);

  @override
  RegisterCardWizardState<RegisterCardWizard> myState() =>
      _RegisterRoleCardState();
}

class _RegisterRoleCardState extends RegisterCardWizardState<RegisterRoleCard> {
  List<bool> rolesToggles = [false, false, false];

  _RegisterRoleCardState() {
    switch (viewModel.selectedRole) {
      case RoleType.CLIENT:
        rolesToggles[0] = true;
        break;
      case RoleType.PARTNER:
        rolesToggles[1] = true;
        break;
      case RoleType.EXECUTOR:
        rolesToggles[2] = true;
        break;
      default:
        throw StateError('No role found');
    }
  }

  _roles() => SizedBox(
        width: 300,
        child: ToggleButtons(
          borderRadius: BorderRadius.circular(4.0),
          constraints: BoxConstraints(minHeight: 50.0),
          isSelected: rolesToggles,
          direction: Axis.vertical,
          onPressed: (index) {
            setState(() {
              rolesToggles[0] = false;
              rolesToggles[1] = false;
              rolesToggles[2] = false;
              rolesToggles[index] = true;
            });
          },
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.account_box),
                VerticalDivider(
                  width: 10,
                ),
                Text('Заказчик')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.account_balance),
                VerticalDivider(
                  width: 10,
                ),
                Text('Партнер')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.handyman_sharp),
                VerticalDivider(
                  width: 10,
                ),
                Text('Исполнитель')
              ],
            )
          ],
        ),
      );

  RoleType _selectedRole() {
    if (rolesToggles[0])
      return RoleType.CLIENT;
    else if (rolesToggles[1])
      return RoleType.PARTNER;
    else
      return RoleType.EXECUTOR;
  }

  @override
  List<Widget> body() {
    return [_roles()];
  }

  @override
  String description() {
    return "Выберите роль";
  }

  @override
  Future onNext() async {
    viewModel.selectedRole = _selectedRole();
    toNextPage.call();
  }
}
