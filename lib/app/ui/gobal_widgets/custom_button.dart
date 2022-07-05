import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String textButton;
  const CustomButton({Key? key, this.onPressed, required this.textButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      child: SizedBox(
        width: width,
        height: 60,
        child: Center(
          child: Text(
            textButton,
            style: const TextStyle(fontSize: 17),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
