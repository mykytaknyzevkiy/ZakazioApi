import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

class LoginCard extends StatefulWidget {
  final Function() onRegister;
  final Function() onForgotPassword;

  const LoginCard({required this.onRegister, required this.onForgotPassword});

  @override
  State<StatefulWidget> createState() {
    return _LoginCardState(onRegister, onForgotPassword);
  }
}

class _LoginCardState extends State<LoginCard> {
  final _userRepository = UserRepository.instance();

  bool _isLoading = false;

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool isLoginBtnEnable = false;

  bool isLoginFailed = false;

  final Function() onRegister;
  final Function() onForgotPassword;

  _LoginCardState(this.onRegister, this.onForgotPassword) {
    _emailController.addListener(() {
      setState(() {
        isLoginBtnEnable = _emailController.text.isValidEmail() &&
            _passwordController.text.isNotEmpty;
        isLoginFailed = false;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        isLoginBtnEnable = _emailController.text.isValidEmail() &&
            _passwordController.text.isNotEmpty;
        isLoginFailed = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController.text = "super_admin@zakazy.online";
    _passwordController.text = "eiucvojkochoer";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        children: [
          _authTitle(),
          Divider(
            height: 40,
            color: Colors.transparent,
          ),
          _emailFiled(),
          Divider(
            height: 20,
            color: Colors.transparent,
          ),
          _passwordFiled(),
          Divider(
            height: 30,
            color: Colors.transparent,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 30,
            children: [
              (!_isLoading
                  ? MyButton(
                      title: "ВОЙТИ",
                      onPressed: () {
                        _onLogin();
                      },
                      isEnable: isLoginBtnEnable,
                      backgroundColor: primaryColor,
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ))
            ],
          ),
          Divider(
            height: 40,
            color: Colors.transparent,
          ),
          Text("или"),
          Divider(
            height: 40,
            color: Colors.transparent,
          ),
          FreeButton(
              title: "Создать аккаунт",
              onPressed: () {
                _onRegister();
              },
              textColor: Colors.black,
              isEnable: !_isLoading)
        ],
      ),
    );
  }

  _authTitle() => Text("Авторизация Zakazy",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500));

  _emailFiled() {
    return SizedBox(
      width: 300,
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
            icon: Icon(Icons.email),
            labelText: 'Email',
            border: OutlineInputBorder()),
        enabled: !_isLoading,
      ),
    );
  }

  _passwordFiled() {
    return SizedBox(
      width: 300,
      child: TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Пароль',
              border: OutlineInputBorder(),
              errorText: isLoginFailed ? "Не верный пароль" : null),
          enabled: !_isLoading),
    );
  }

  _onLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    setState(() {
      isLoginFailed = false;
      _isLoading = true;
    });

    final isLogin = await _userRepository.signIn(email, password);

    if (isLogin) {
      await _userRepository.initUser();
    }

    setState(() {
      isLoginFailed = !isLogin;
      _isLoading = false;
    });
  }

  _onRegister() {
    onRegister.call();
  }

  _onForgotPassword() {}
}
