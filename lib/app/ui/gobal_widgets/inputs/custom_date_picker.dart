import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomImputDatePicker extends StatefulWidget {
  final void Function(DateTime)? onChanged;
  final String label;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(DateTime?)? validator;

  const CustomImputDatePicker(
      {Key? key,
      this.onChanged,
      required this.label,
      this.inputType,
      this.isPassword = false,
      this.validator})
      : super(key: key);

  @override
  State<CustomImputDatePicker> createState() => _CustomImputDatePickerState();
}

class _CustomImputDatePickerState extends State<CustomImputDatePicker> {
  late bool _obscureText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
        validator: widget.validator,
        //initialValue: DateTime.now(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        builder: (state) {
          DateTime? value = state.value;
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
                    controller: value != null
                        ? TextEditingController(
                            text: DateFormat.yMEd("ES").format(value))
                        : null,
                    obscureText: _obscureText,
                    keyboardType: widget.inputType,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            right: 0, left: 10, top: 8.0, bottom: 8.0),
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
                        prefixIcon: const Icon(
                          Icons.date_range_outlined,
                          color: Colors.black,
                        ),
                        hintText: widget.label),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());

                      showDatePicker(
                        context: context,
                        locale: const Locale("es", "ES"),
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1980),
                        lastDate: DateTime(2222),
                      ).then((value) {
                        if (widget.validator != null) {
                          state.setValue(value!);
                          state.validate();
                        }

                        if (widget.onChanged != null) {
                          log(value.toString());
                          widget.onChanged!(value!);
                        }
                      }).ignore();
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
