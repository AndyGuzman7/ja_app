import 'package:flutter/material.dart';

class CustomContainerRounded extends StatelessWidget {
  final Widget child;
  final bool widthAuto;
  const CustomContainerRounded(
      {Key? key, required this.child, this.widthAuto = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      //width: width,
      width: !widthAuto ? double.infinity : null,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 102, 133, 230),
            Color.fromARGB(255, 127, 159, 229)
          ],
        ),
      ),
      child: child,
    );
  }
}
