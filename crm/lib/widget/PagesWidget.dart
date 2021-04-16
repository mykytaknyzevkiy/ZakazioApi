import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zakazy_crm_v2/conts.dart';

class PagesWidget extends StatelessWidget {
  final int pageLength;
  final int currentPage;
  final Function(int) onSelect;

  const PagesWidget(
      {required this.pageLength,
      required this.currentPage,
      required this.onSelect});

  @override
  Widget build(BuildContext context) =>
      SizedBox(width: double.infinity, child: numericals());

  List<String> pagesList() {
    List<String> list = List<String>.of({});

    if (pageLength <= 5) {
      for (int i = 1; i <= pageLength; i++) {
        list.add(i.toString());
      }
    } else {
      for (int i = currentPage; i < pageLength; i++) {
        list.add((i + 1).toString());
        if (list.length == 5) {
          break;
        }
      }

      if (currentPage + 1 != pageLength) {
        list.add("...");

        list.add(pageLength.toString());
      }

      if (currentPage > 0) {
        final newList = List<String>.of({});

        newList.add("1");

        if (currentPage > 1) {
          newList.add("...");
        }

        newList.addAll(list);

        list = newList;
      }
    }

    return list;
  }

  Widget numericals() => Wrap(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            pagesList().length,
            (index) => GestureDetector(
                onTap: () {
                  final pageNum = int.tryParse(pagesList()[index]);
                  if (pageNum != null) {
                    onSelect(pageNum - 1);
                  }
                },
                child: numViewHolder(index))),
      );

  Widget numViewHolder(int index) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 35,
          height: 35,
          color: (currentPage + 1).toString() == pagesList()[index]
              ? primaryColor
              : accentColor,
          child: Center(
            child: Text(
              pagesList()[index],
              style: TextStyle(
                  color: (currentPage + 1).toString() == pagesList()[index]
                      ? accentColor
                      : primaryColor),
            ),
          ),
        ),
      );
}
