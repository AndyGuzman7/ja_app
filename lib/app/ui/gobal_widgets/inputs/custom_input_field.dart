import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomInputField extends StatefulWidget {
  final void Function(String)? onChanged;
  final String label;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Icon? icon;
  final bool isNoSpace;
  final String? initialValue;
  final bool isCapitalize;

  const CustomInputField({
    Key? key,
    this.onChanged,
    this.initialValue,
    this.isCapitalize = false,
    required this.label,
    this.inputType,
    this.icon,
    this.isNoSpace = true,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _obscureText;
  TextEditingController? _textEditingController;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    _textEditingController = TextEditingController(text: widget.initialValue);
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onChanged?.call(widget.initialValue ?? '');
    });*/
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contentPadding =
        EdgeInsets.only(right: 0, left: 10, top: 8.0, bottom: 8.0);
    final enableBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
          width: 1.7,
          style: BorderStyle.solid,
          color: Color.fromARGB(255, 218, 218, 218)),
    );
    final focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
          width: 1.7,
          style: BorderStyle.solid,
          color: Color.fromARGB(255, 218, 218, 218)),
    );

    return FormField<String>(
      initialValue: widget.initialValue ?? '',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      builder: (state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 48,
                child: TextField(
                  obscureText: _obscureText,
                  keyboardType: widget.inputType,
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    prefixIcon: widget.icon,
                    contentPadding: contentPadding,
                    enabledBorder: enableBorder,
                    focusedBorder: focusBorder,
                    hintText: widget.label,
                    suffixIcon: widget.isPassword
                        ? IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1.7,
                        color: Color.fromARGB(255, 218, 218, 218),
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  textCapitalization: widget.isCapitalize
                      ? TextCapitalization.sentences
                      : TextCapitalization.none,
                  onChanged: (text) {
                    final trimmedText =
                        widget.isNoSpace ? text.replaceAll(' ', '') : text;
                    if (widget.validator != null) {
                      state.didChange(trimmedText);
                      state.validate();
                    }
                    widget.onChanged?.call(trimmedText);
                  },
                ),
              ),
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    state.errorText!,
                    style: TextStyle(color: Color.fromARGB(255, 194, 18, 18)),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class CustomImputField2 extends StatefulWidget {
  final void Function(String)? onChanged;
  final String label;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Icon? icon;
  final bool isNoSpace;
  final String? value;
  final bool isCapitanize;
  const CustomImputField2(
      {Key? key,
      this.onChanged,
      this.value,
      this.isCapitanize = false,
      required this.label,
      this.inputType,
      this.icon,
      this.isNoSpace = true,
      this.isPassword = false,
      this.validator})
      : super(key: key);

  @override
  State<CustomImputField2> createState() => _CustomImputFieldState2();
}

class _CustomImputFieldState2 extends State<CustomImputField2> {
  late bool _obscureText;
  String? value;
  TextEditingController? s;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = widget.isPassword;
    if (widget.value == null) return;
    value = widget.value!;
    s = TextEditingController(text: value);
    SchedulerBinding.instance
        .addPostFrameCallback((_) => {widget.onChanged!(widget.value!)});
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        validator: widget.validator,
        initialValue: s != null ? s!.text : "",
        autovalidateMode: AutovalidateMode.onUserInteraction,
        builder: (state) {
          value = null;
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
                    controller: s,
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
