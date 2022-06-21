import 'package:flutter/material.dart';

class CustomTextFiled extends StatefulWidget {
  const CustomTextFiled({
    Key? key,
    this.focusNode,
    required this.fillColor,
    required this.focusColor,
    // add whaterver properties that your textfield needs. like controller and ..
  }) : super(key: key);

  final FocusNode? focusNode;
  final Color focusColor;
  final Color fillColor;

  @override
  _CustomTextFiledState createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  late FocusNode focusNode;
  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(() {
      setState(() {
        print("object");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      decoration: InputDecoration(
        filled: true,
        fillColor: focusNode.hasFocus ? widget.focusColor : widget.fillColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 0.0,
              color: focusNode.hasFocus ? Colors.red : widget.fillColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              (10.0),
            ),
          ),
        ),
        labelText: "Enter Email",
        hoverColor: Colors.red,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(),
        ),
        //fillColor: Colors.green
      ),
      validator: (val) {
        if (val!.length == 0) {
          return "Email cannot be empty";
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        fontFamily: "Poppins",
      ),
    );
  }
}
