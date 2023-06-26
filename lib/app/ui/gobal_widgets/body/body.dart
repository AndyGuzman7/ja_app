import 'package:flutter/material.dart';

class CustomBodyA extends StatelessWidget {
  final Widget child;
  const CustomBodyA({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: SizedBox(
        height: height,
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
