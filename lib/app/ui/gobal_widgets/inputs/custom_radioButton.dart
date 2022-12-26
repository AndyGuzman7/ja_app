import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ja_app/app/ui/gobal_widgets/drop_dow/custom_dropDownButton%20copy.dart';

// ignore: must_be_immutable
class CustomRadioButtons<T> extends StatelessWidget {
  void Function(T) callback;
  late T character;
  dynamic value;
  String title;
  CustomRadioButtons({
    required this.title,
    required this.character,
    required this.callback,
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      leading: Radio<T>(
        value: character,
        groupValue: value,
        onChanged: ((value) {
          callback(value!);
        }),
      ),
    );
  }
}
