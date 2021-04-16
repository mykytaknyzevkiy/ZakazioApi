import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/screen/register/RegisterViewModel.dart';

// ignore: must_be_immutable
abstract class RegisterCardWizard extends StatefulWidget {
  late Function() toNextPage;

  RegisterCardWizardState myState();

  late RegisterCardWizardState _currentState;

  RegisterCardWizard(this.toNextPage);

  @override
  State<StatefulWidget> createState() {
    _currentState = myState();
    _currentState.toNextPage = toNextPage;
    return _currentState;
  }

  Future onNext() async {
    await _currentState.onNext();
  }
}

abstract class RegisterCardWizardState<T extends RegisterCardWizard>
    extends State<T> {
  RegisterViewModel viewModel = RegisterViewModel.create();

  late Function() toNextPage;

  String description();

  List<Widget> body();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        Text(description()),
        Divider(
          height: 30,
          color: Colors.transparent,
        ),
        Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          children: body(),
        ),
        Divider(
          height: 30,
          color: Colors.transparent,
        )
      ],
    );
  }

  Future onNext();
}
