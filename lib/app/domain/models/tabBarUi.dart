import 'package:flutter/material.dart';

class TabBarUi {
  late final Tab tabBar;
  late final Widget tabBarView;
  final Icon? icon;
  String? nameTabBar;
  final String? permissons;
  Widget children;

  TabBarUi(
    this.nameTabBar,
    this.icon,
    this.children,
    this.permissons,
  ) {
    tabBar = Tab(
      icon: icon,
      text: nameTabBar,
    );
    tabBarView = children;
  }
}
