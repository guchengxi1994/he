import 'package:flutter/material.dart';
import 'package:he/src/layout/layout_notifier.dart';

typedef OnItemClicked = void Function(int index);

class SidebarItem {
  final Widget icon;
  final Widget iconInactive;
  final OnItemClicked? onClick;
  final int index;
  String title;

  SidebarItem({
    required this.icon,
    required this.iconInactive,
    this.onClick,
    required this.index,
    this.title = "",
  });
}

class SidebarItemWidget extends StatelessWidget {
  const SidebarItemWidget(
      {super.key, required this.item, required this.notifier});

  final SidebarItem item;
  final LayoutNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Tooltip(
          message: item.title,
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: notifier.value == item.index
                  ? Colors.grey[200]
                  : Colors.white,
            ),
            width: 30,
            height: 30,
            child: notifier.value == item.index ? item.icon : item.iconInactive,
          ),
        ),
        onTap: () {
          if (item.onClick != null) {
            item.onClick!(item.index);
          }
          notifier.change(item.index);
        },
      ),
    );
  }
}
