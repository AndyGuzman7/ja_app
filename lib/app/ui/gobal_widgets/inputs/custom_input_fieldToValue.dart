import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomImputFieldToValue extends StatefulWidget {
  final void Function(String)? onChanged;
  final String label;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Icon? icon;
  final bool isNoSpace;
  final String? value;
  const CustomImputFieldToValue(
      {Key? key,
      this.onChanged,
      this.value,
      required this.label,
      this.inputType,
      this.icon,
      this.isNoSpace = true,
      this.isPassword = false,
      this.validator})
      : super(key: key);

  @override
  State<CustomImputFieldToValue> createState() =>
      _CustomImputFieldToValueState();
}

class _CustomImputFieldToValueState extends State<CustomImputFieldToValue> {
  late bool _obscureText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    log("asdasd");
    log(widget.label);
    return FormField<String>(
        validator: widget.validator,
        initialValue: '',
        autovalidateMode: AutovalidateMode.onUserInteraction,
        builder: (state) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 48,
                  child: TextField(
                    obscureText: _obscureText,
                    keyboardType: widget.inputType,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            right: 0, left: 10, top: 8.0, bottom: 8.0),

                        //isDense: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 1.7,
                                style: BorderStyle.solid,
                                color: Color.fromARGB(255, 218, 218, 218))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 1.7,
                                style: BorderStyle.solid,
                                color: Color.fromARGB(255, 218, 218, 218))),
                        prefixIcon: widget.icon != null
                            ? Icon(
                                widget.icon!.icon,
                                color: Colors.black,
                              )
                            : null,
                        suffixIcon: widget.isPassword
                            ? CupertinoButton(
                                child: Icon(_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  _obscureText = !_obscureText;
                                  setState(() {});
                                })
                            : null,
                        hintText: widget.label
                        //labelText: widget.label,
                        /*border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),*/
                        ),
                    textCapitalization: !widget.isPassword
                        ? TextCapitalization.sentences
                        : TextCapitalization.none,
                    onChanged: (text) {
                      if (widget.validator != null) {
                        // ignore: invalid_use_of_protected_member
                        widget.isNoSpace
                            ? text = text.replaceAll(" ", "")
                            : null;
                        state.setValue(text);
                        state.validate();
                      }
                      if (widget.onChanged != null) {
                        widget.onChanged!(text);
                      }
                    },
                  ),
                ),
                if (state.hasError)
                  Text(
                    state.errorText!,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 194, 18, 18)),
                  )
              ],
            ),
          );
        });
  }
}
