import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget {
  Color color;
  Color textColor;
  String text;

  Function onPressed;

  ButtonApp(
      {this.color = Colors.black,
      this.textColor = Colors.white,
      required this.onPressed,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        onPressed();
      },
      color: color,
      textColor: textColor,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
