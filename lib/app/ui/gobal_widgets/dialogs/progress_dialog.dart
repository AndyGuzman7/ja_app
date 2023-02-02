import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ProgressDialog {
  static void show(BuildContext context, width, height) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => WillPopScope(
          child: Container(
            width: width,
            height: height,
            color: Colors.black12,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
          onWillPop: () async => false),
    );
  }
}
