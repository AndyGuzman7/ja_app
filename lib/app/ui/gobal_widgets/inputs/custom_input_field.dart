import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomImputField extends StatefulWidget {
  final void Function(String)? onChanged;
  final String label;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Icon? icon;
  const CustomImputField(
      {Key? key,
      this.onChanged,
      required this.label,
      this.inputType,
      this.icon,
      this.isPassword = false,
      this.validator})
      : super(key: key);

  @override
  State<CustomImputField> createState() => _CustomImputFieldState();
}

class _CustomImputFieldState extends State<CustomImputField> {
  late bool _obscureText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
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
                    onChanged: (text) {
                      if (widget.validator != null) {
                        // ignore: invalid_use_of_protected_member
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
