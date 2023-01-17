import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/custom_dialog.dart';

abstract class Dialogs {
  static Future<void> alert(BuildContext context,
      {String? title, String? content, String okText = "OK"}) {
    return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: title != null
            ? Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : null,
        content: content != null ? Text(content) : null,
        actions: [
          CupertinoDialogAction(
            child: Text(
              okText,
            ),
            onPressed: () {
              Navigator.pop(_);
            },
          )
        ],
      ),
    );
  }
}

class CustomDialogSimple {
  final BuildContext context;
  final String title;
  List<Widget>? actions;
  Widget? content;
  CustomDialogSimple(this.context, this.title, {this.actions, this.content});

  dissmisAlertDialog() {
    Navigator.pop(context);
  }

  showAlertDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomDialog(
          title,
          actions: actions,
          content: content,
        );
      },
    );
  }
}
