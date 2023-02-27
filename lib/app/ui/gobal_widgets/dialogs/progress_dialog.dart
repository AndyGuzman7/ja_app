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

  static void showV2(context, text) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 40,
            color: Color.fromARGB(255, 255, 255, 255),
            alignment: Alignment.center,
            child: Row(
              children: [
                const CircularProgressIndicator(
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Text(
                  text,
                  textAlign: TextAlign.center,
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}

abstract class ProgressDialoText {
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

abstract class ProgressDialoTextV2 {
  static void show(BuildContext context, width, height) {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: Container(
          width: width,
          height: 80,
          color: Color.fromARGB(255, 255, 255, 255),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
