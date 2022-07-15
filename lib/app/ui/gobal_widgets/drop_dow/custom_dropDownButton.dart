import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:ja_app/app/domain/models/brochure.dart';

class CustomDropDownButton extends StatefulWidget {
  final void Function(Brochure)? onChanged;
  final List<Brochure> listBrochure;

  final String? Function(Brochure?)? validator;

  const CustomDropDownButton(
      {Key? key,
      required this.onChanged,
      required this.listBrochure,
      this.validator})
      : super(key: key);

  @override
  _CustomDropDownButtonState createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  Brochure? _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<Brochure>(
            value: _chosenValue,
            //elevation: 5,
            style: TextStyle(color: Colors.black),

            items: widget.listBrochure.map(
              (Brochure valueItem) {
                return DropdownMenuItem<Brochure>(
                  value: valueItem,
                  child: Text(valueItem.spanish + " " + (valueItem.age ?? '')),
                );
              },
            ).toList(),
            validator: widget.validator,
            hint: const Text(
              "Please choose a option",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),

            onChanged: (Brochure? value) {
              setState(() {
                _chosenValue = value!;
                widget.onChanged!(value);
              });
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
