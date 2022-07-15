import 'package:flutter/material.dart';

class CustomContainerInformation extends StatelessWidget {
  final Color backgroundColor;
  final Color colorText;
  final String text;

  final Icon icon;
  const CustomContainerInformation(
      {Key? key,
      required this.backgroundColor,
      required this.colorText,
      required this.text,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      //color: backgroundColor,
      //width: width,
      // width: !widthAuto ? double.infinity : null,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: TextStyle(color: colorText, fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
