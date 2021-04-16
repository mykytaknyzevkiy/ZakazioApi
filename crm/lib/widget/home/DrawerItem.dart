import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/conts.dart';

// ignore: must_be_immutable
class DrawerItem extends StatelessWidget {
  final int phoneSize;
  final BuildContext context;
  final String title;
  final IconData icon;
  final bool isSelected;

  bool isHover = false;

  final reBuild = BehaviorSubject<int>.seeded(0);

  DrawerItem(this.title, this.icon, this.isSelected, this.context, this.phoneSize);

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: reBuild,
        builder: (context, snapshot) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 8,
                  height: 45,
                  decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                ),
                VerticalDivider(
                  width: MediaQuery.of(context).size.width >=  phoneSize ? 15 : 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 45,
                  width: (MediaQuery.of(context).size.width >= phoneSize) ? 225 : null,
                  decoration: BoxDecoration(
                      color: isSelected
                          ? primaryColor
                          : isHover
                              ? primaryColor.withAlpha(50)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: (MediaQuery.of(context).size.width >= phoneSize) ? 16 : 6,
                        right: (MediaQuery.of(context).size.width >= phoneSize) ? 16 : 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          color: isSelected ? accentColor : Colors.black87,
                        ),
                        (MediaQuery.of(context).size.width >= phoneSize)
                        ? VerticalDivider(
                          width: 10,
                          color: Colors.transparent,
                        )
                        : Container(),
                        (MediaQuery.of(context).size.width >= phoneSize)
                        ? Text(
                          title,
                          style: TextStyle(
                              color: isSelected ? accentColor : Colors.black87),
                        )
                        : Container()
                      ],
                    ),
                  ),
                ),
                VerticalDivider(
                  width: MediaQuery.of(context).size.width >=  phoneSize ? 15 : 10,
                )
              ],
            ),
            onHover: (event) {
              isHover = true;
              reBuild.add(6);
            },
            onExit: (event) {
              isHover = false;
              reBuild.add(7);
            },
          );
        },
      );
}
