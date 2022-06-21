import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class CustomTextFieldv2 extends StatefulWidget {
  void Function(String value)? assignValue;
  TextInputType typeIput;
  String hint;
  String value;
  double marginLeft;
  double marginRight;
  double marginBotton;
  double marginTop;
  MultiValidator? multiValidator;
  double heightNum;
  bool obscureText;
  bool readOnly;
  bool filled;
  Color fillColor;
  _CustomTextFieldv2State _customTextFieldState = new _CustomTextFieldv2State();
  TextEditingController _controller = TextEditingController();

  TextEditingController get controller {
    return _controller;
  }

  CustomTextFieldv2({
    Key? key,
    this.typeIput = TextInputType.text,
    this.hint = "Campo de text",
    this.marginLeft = 0,
    this.marginRight = 0,
    this.marginTop = 5,
    this.marginBotton = 5,
    this.heightNum = 100,
    this.obscureText = false,
    this.readOnly = false,
    this.filled = false,
    this.fillColor = Colors.yellow,
    this.value = '',
    this.multiValidator,
    this.assignValue,
  }) : super(key: key);

  @override
  _CustomTextFieldv2State createState() {
    _controller.text = value;
    return _customTextFieldState;
  }

  String getValue() {
    value = _controller.text;
    return value;
  }

  setValue(String value) {
    _customTextFieldState.setValue(value);
  }

  void changeHeightTextField(double num) {
    _customTextFieldState.changeHeightTextField(num);
  }
}

class _CustomTextFieldv2State extends State<CustomTextFieldv2> {
  changeHeightTextField(double num) {
    setState(() {
      widget.heightNum = num;
    });
  }

  changeColor() {}

  setValue(String value) {
    setState(() {
      widget._controller.text = value;
    });
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: widget.marginTop,
              bottom: widget.marginBotton,
              left: widget.marginLeft,
              right: widget.marginRight),
          width: width,
          alignment: Alignment.bottomCenter,
          child: TextFormField(
            keyboardType: widget.typeIput,
            onChanged: widget.assignValue,
            obscureText: widget.obscureText,
            readOnly: widget.readOnly,
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              var validators = widget.multiValidator!.validators;
              for (FieldValidator validator in validators) {
                if (!validator.isValid(value)) {
                  return validator.errorText;
                }
              }
            },
            textAlignVertical: TextAlignVertical.center,
            controller: widget._controller,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              focusColor: Colors.green,
              errorStyle:
                  const TextStyle(color: Color.fromARGB(255, 136, 0, 0)),
              contentPadding: EdgeInsets.all(10),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 136, 0, 0), width: 2.0),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              hintText: widget.hint,
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(width: 2.0, color: Colors.black),
              ),
              filled: widget.filled,
              fillColor: widget.fillColor,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 0.0),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
