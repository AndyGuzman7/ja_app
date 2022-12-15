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
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          textStyle: MaterialStateProperty.all(TextStyle(color: textColor)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
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
    );
  }
}
