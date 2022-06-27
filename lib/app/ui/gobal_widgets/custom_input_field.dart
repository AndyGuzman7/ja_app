import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomImputField extends StatefulWidget {
  final void Function(String)? onChanged;
  final String label;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(String?)? validator;
  const CustomImputField(
      {Key? key,
      this.onChanged,
      required this.label,
      this.inputType,
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                obscureText: _obscureText,
                keyboardType: widget.inputType,
                decoration: InputDecoration(
                  suffixIcon: widget.isPassword
                      ? CupertinoButton(
                          child: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            _obscureText = !_obscureText;
                            setState(() {});
                          })
                      : Container(
                          width: 0,
                        ),
                  labelText: widget.label,
                  border: OutlineInputBorder(),
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
              if (state.hasError)
                Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.redAccent),
                )
            ],
          );
        });
  }
}
