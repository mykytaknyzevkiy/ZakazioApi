import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/conts.dart';

class MyButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  final Color? backgroundColor;
  final Color? foregroundColor;

  bool isEnable;

  final _reBuild = BehaviorSubject<int>.seeded(0);

  MyButton(
      {required this.title,
      required this.onPressed,
      this.backgroundColor,
      this.foregroundColor,
      required this.isEnable});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _reBuild,
      builder: (context, snapShot) => ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 4, primary: backgroundColor, onPrimary: foregroundColor),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width > phoneSize ? 16 : 8),
          child: Text(title.toUpperCase()),
        ),
        onPressed: isEnable ? onPressed : null,
      ),
    );
  }

  setEnable(bool isEnable) {
    this.isEnable = isEnable;
    _reBuild.add(10);
  }

  _close() {
    _reBuild.close();
  }
}

class SmallButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final bool isEnable;
  final double? elevation;

  SmallButton(
      {required this.title,
      required this.onPressed,
      this.backgroundColor,
      this.foregroundColor,
      required this.isEnable,
      this.elevation});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width > phoneSize ? 4 : 2),
          elevation: elevation != null ? elevation : 4,
          primary: backgroundColor,
          onPrimary: foregroundColor),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(title.toUpperCase(),
              style: TextStyle(fontSize: 12), textAlign: TextAlign.start),
        ),
      ),
      onPressed: isEnable ? onPressed : null,
    );
  }
}

class FreeButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  final Color? textColor;

  final bool isEnable;

  FreeButton(
      {required this.title,
      required this.onPressed,
      this.textColor,
      required this.isEnable});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width > phoneSize ? 16 : 8),
        child: Text(title.toUpperCase()),
      ),
      onPressed: isEnable ? onPressed : null,
      style: OutlinedButton.styleFrom(
        primary: textColor ?? primaryColor,
      ),
    );
  }
}

class SmallFreeButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  final Color? textColor;

  final bool isEnable;

  SmallFreeButton(
      {required this.title,
      required this.onPressed,
      this.textColor,
      required this.isEnable});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width > phoneSize ? 4 : 2),
        child: Text(title.toUpperCase()),
      ),
      onPressed: isEnable ? onPressed : null,
      style: OutlinedButton.styleFrom(
        primary: textColor ?? primaryColor,
      ),
    );
  }
}

class TextNButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const TextNButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(title),
    );
  }
}
