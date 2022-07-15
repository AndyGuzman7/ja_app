import 'package:flutter/material.dart';

class BackGroundIamge extends StatelessWidget {
  final Widget child;
  final Image image; // = Image.asset('assets/images/1743165.jpg');
  const BackGroundIamge({Key? key, required this.child, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: Container(
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(image: image.image, fit: BoxFit.fill)),
        child: Container(
          height: height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(125, 255, 255, 255),
                Color.fromARGB(235, 255, 255, 255),
                Color.fromARGB(250, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.2, 0.8, 1],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
