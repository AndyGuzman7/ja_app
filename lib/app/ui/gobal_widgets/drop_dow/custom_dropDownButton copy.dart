import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/brochure.dart';

class CustomDropDownButtonv2<T> extends StatefulWidget {
  final void Function(Brochure)? onChanged;
  final List<T> lisItems;

  final String? Function(Brochure?)? validator;

  CustomDropDownButtonv2(
      {Key? key,
      required this.onChanged,
      this.validator,
      required this.lisItems})
      : super(key: key);

  @override
  _CustomDropDownButtonv2State createState() => _CustomDropDownButtonv2State();
}

class _CustomDropDownButtonv2State extends State<CustomDropDownButtonv2> {
  Brochure? _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<dynamic>(
            value: _chosenValue,
            style: TextStyle(color: Colors.black, wordSpacing: 0),

            items: widget.lisItems.map(
              (dynamic valueItem) {
                return DropdownMenuItem<dynamic>(
                  value: valueItem,
                  child: Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    color: Colors.red,
                    child: Text("sdsd"),
                  ),
                );
              },
            ).toList(),
            //validator: widget.validator,
            hint: const Text(
              "Please",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(right: 0, left: 10, top: 8.0, bottom: 8.0),
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
            ),

            onChanged: (dynamic value) {
              /*setState(() {
                _chosenValue = value!;
                widget.onChanged!(value);
              });*/
            },
          ),
          /* if (state.hasError)
            Text(
              state.errorText!,
              style: const TextStyle(color: Color.fromARGB(255, 194, 18, 18)),
            )*/
        ],
      ),
    );
  }
}

/*class DropdownButtonExample<T> extends StatelessWidget {
  List<T> lisItems;
  final String hint;
  void Function(T) callback;
  DropdownButtonExample({
    required this.callback,
    required this.hint,
    required this.lisItems,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField<T>(
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(top: 8.0, bottom: 8.0),
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
                  ),
                  onChanged: ((value) => callback),
                  iconSize: 30,
                  icon: (null),
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  hint: Text(hint),
                  items: lisItems.map((item) {
                    return DropdownMenuItem(
                      child: Text(item.toString()),
                      value: item,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/

class CustomRadioButton extends StatefulWidget {
  CustomRadioButton({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

enum SingingCharacter { male, female }

enum BautizatedCharacter { yes, no }

class _CustomRadioButtonState extends State<CustomRadioButton> {
  SingingCharacter? _character = SingingCharacter.male;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: const Text('Masculino'),
            leading: Radio<SingingCharacter>(
              value: SingingCharacter.male,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: const Text('Femenino'),
            leading: Radio<SingingCharacter>(
              value: SingingCharacter.female,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
