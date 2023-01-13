import 'package:flutter/material.dart';

class TabBarUi {
  late final Tab tabBar;
  late final Widget tabBarView;
  String? nameTabBar;
  String? permissons;
  Widget children;

  TabBarUi(
    this.nameTabBar,
    this.children,
    this.permissons,
  ) {
    tabBar = Tab(
      text: nameTabBar,
    );
    tabBarView = children;
  }
}
