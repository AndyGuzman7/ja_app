import 'package:flutter/material.dart';

class CustomParagraph extends StatelessWidget {
  final String paragraph;
  final EdgeInsets padding;
  const CustomParagraph(
      {Key? key, required this.paragraph, this.padding = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        paragraph,
        textAlign: TextAlign.justify,
        style: const TextStyle(color: Colors.black54, fontSize: 15),
      ),
    );
  }
}
