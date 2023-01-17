import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ja_app/app/utils/MyColors.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Icon? icon;
  final Widget? content;
  final List<Widget>? actions;
  const CustomDialog(this.title,
      {this.actions, this.icon, this.content, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      iconPadding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      icon: icon != null
          ? Icon(
              icon!.icon,
              size: 40,
              color: CustomColorPrimary().materialColor,
            )
          : null,
      actionsPadding: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 15,
      ),
      contentPadding:
          const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      titleTextStyle: const TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.white,
      content: content,
      actions: actions,
    );
  }
}
