import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

class HelpMessageBubble {
  final String message;
  final MapEntry<String, Function>? buttonData;

  HelpMessageBubble(this.message, this.buttonData);
}

class HelpMessageBubbleWidget extends StatelessWidget {
  final String _message;
  final MapEntry<String, Function>? _buttonData;
  final Function _onClose;

  const HelpMessageBubbleWidget(
      this._message,
      this._buttonData,
      this._onClose);

  @override
  Widget build(BuildContext context) => Card(
    elevation: 8,
    color: primaryColor,
    child: SizedBox(
      width: 400,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 400,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ваш помошник",
                          style: TextStyle(
                              color: accentColor,
                              fontSize: 18
                          ),
                        ),
                        Divider(
                            height: 25,
                            color: Colors.transparent
                        ),
                        Text(
                          _message,
                          style: TextStyle(
                              color: accentColor
                          ),
                        ),
                      ],
                    ),
                    Divider(
                        height: 15,
                        color: Colors.transparent
                    ),
                    _buttonData != null
                        ? MyButton(
                        backgroundColor: accentColor,
                        foregroundColor: primaryColor,
                        title: _buttonData!.key,
                        onPressed: () {
                          _buttonData!.value.call();
                          _onClose.call();
                        },
                        isEnable: true
                    )
                        : Container()
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () => _onClose()
              ),
            )
          ],
        ),
      ),
    ),
  );
}