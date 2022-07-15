import 'package:flutter/material.dart';

class CustomContainerImageRounded extends StatelessWidget {
  final Image child;
  const CustomContainerImageRounded({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundImage: child.image,
    );
  }
}
