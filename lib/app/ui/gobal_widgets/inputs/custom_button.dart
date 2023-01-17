import 'package:flutter/material.dart';
import 'package:ja_app/app/utils/MyColors.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? textButton;
  final Color? colorButton;
  final Color? colorTextButton;

  final Color? colorBorderButton;
  final double height;
  final double? width;
  final Icon? icon;
  const CustomButton({
    Key? key,
    this.onPressed,
    this.colorBorderButton,
    this.icon,
    this.textButton,
    this.height = 65,
    this.width,
    this.colorButton,
    this.colorTextButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthContext = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: SizedBox(
          height: height,
          child: Center(
            widthFactor: width ?? widthContext,
            heightFactor: 2.4,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                icon ?? const SizedBox(),
                (textButton != null && icon != null)
                    ? SizedBox(
                        width: 5,
                      )
                    : SizedBox(),
                textButton != null
                    ? Text(
                        textButton!,
                        style: TextStyle(fontSize: 17, color: colorTextButton),
                        textAlign: TextAlign.center,
                      )
                    : const SizedBox(
                        width: 0,
                      )
              ],
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorButton,
          side: colorBorderButton != null
              ? BorderSide(color: colorBorderButton!)
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
