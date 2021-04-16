import 'package:flutter/material.dart';

abstract class RightScreen extends StatelessWidget {

  double width(BuildContext context);

  Widget body(BuildContext context);

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey.withAlpha(150)
      ),
      Align(
        alignment: Alignment.topRight,
        child: Card(
            elevation: 4,
            child: SizedBox(
              width: width(context),
              height: MediaQuery.of(context).size.height,
              child: Padding(
                  padding: EdgeInsets.all(24),
                  child: body(context)
              ),
            )
        )
      )
    ],
  );

}