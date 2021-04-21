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
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        width: 400,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ваш помощник",
                          style: TextStyle(
                              color: accentColor,
                              fontSize: 18
                          ),
                        ),
                        SizedBox(
                            height: 25
                        ),
                        Text(
                          _message,
                          style: TextStyle(
                              color: accentColor
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 15
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
                )
            ),
            IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () => _onClose()
            )
          ],
        )
      )
    )
  );
}