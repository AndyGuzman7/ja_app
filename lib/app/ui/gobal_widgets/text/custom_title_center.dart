import 'package:flutter/material.dart';

class CustomTitleCenterH1 extends StatelessWidget {
  final String text;
  final Color colorText;
  const CustomTitleCenterH1(
      {Key? key, required this.text, this.colorText = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 1,
      child: Text(
        text,
        style: TextStyle(fontSize: 40, color: colorText),
      ),
    );
  }
}

class CustomTitleCenterH4 extends StatelessWidget {
  final String text;
  const CustomTitleCenterH4({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 17, color: Colors.black54),
        ),
      ),
    );
  }
}
