import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatefulWidget {
  List<dynamic> lisItems;
  final String? Function(T?)? validator;
  final String hint;
  final Icon? icon;
  void Function(dynamic) onChanged;
  CustomDropDown({
    required this.onChanged,
    this.icon,
    required this.validator,
    required this.hint,
    required this.lisItems,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: null,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField<dynamic>(
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1.7,
                          style: BorderStyle.solid,
                          color: Color.fromARGB(255, 218, 218, 218),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1.7,
                          style: BorderStyle.solid,
                          color: Color.fromARGB(255, 218, 218, 218),
                        ),
                      ),
                      prefixIcon: widget.icon != null
                          ? Icon(
                              widget.icon!.icon,
                              color: Colors.black,
                            )
                          : null,
                    ),
                    onChanged: (text) {
                      if (widget.validator != null) {
                        // ignore: invalid_use_of_protected_member
                        var s = text;
                        state.setValue(s);
                        state.validate();
                      }
                      if (widget.onChanged != null) {
                        widget.onChanged(text);
                      }
                    },
                    iconSize: 30,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    hint: Text(widget.hint),
                    items: widget.lisItems.map((item) {
                      return DropdownMenuItem<dynamic>(
                        child: Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          child: Text(
                            item.name,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        value: item,
                      );
                    }).toList(),
                  ),
                ),
              ),
              if (state.hasError)
                Container(
                  color: Colors.black,
                  child: Text(
                    state.errorText!,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 194, 18, 18)),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
