import 'package:flutter/material.dart';
import 'package:ja_app/app/utils/MyColors.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String textButton;
  final Color? colorButton;
  final Color? colorTextButton;
  final double height;
  const CustomButton({
    Key? key,
    this.onPressed,
    required this.textButton,
    this.height = 65,
    this.colorButton,
    this.colorTextButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: SizedBox(
          height: height,
          child: Center(
            widthFactor: width,
            heightFactor: 2.4,
            child: Text(
              textButton,
              style: TextStyle(fontSize: 17, color: colorTextButton),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: colorButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
