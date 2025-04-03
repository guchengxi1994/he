import 'package:flutter/material.dart';
import 'package:he/src/layout/layout_notifier.dart';
import 'package:he/src/layout/sidebar_item.dart';

class SimpleLayout extends StatelessWidget {
  SimpleLayout({super.key, required this.items, required this.children})
      : assert(items.length == children.length);
  final List<SidebarItem> items;
  final List<Widget> children;

  final LayoutNotifier notifier = LayoutNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: notifier,
        builder: (c, s, _) {
          return Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 40,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: items
                          .map((v) => SidebarItemWidget(
                                item: v,
                                notifier: notifier,
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: notifier.controller,
                  children: children,
                ),
              ),
            ],
          );
        });
  }
}
