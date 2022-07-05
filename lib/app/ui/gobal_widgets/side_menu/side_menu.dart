import 'package:flutter/material.dart';

class NavigatorDrawer extends StatelessWidget {
  const NavigatorDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          builderHeader(context),
          builderMenuItems(context),
        ],
      )),
    );
  }

  builderHeader(BuildContext context) {
    return Container();
  }

  builderMenuItems(BuildContext context) {
    return Container();
  }
}
