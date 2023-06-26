import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  final List<dynamic> items;
  final String? Function(dynamic)? validator;
  final String hint;
  final String? cabecera;
  final Icon? icon;
  final void Function(dynamic) onChanged;
  final dynamic initialValue; // Valor inicial definido por el usuario

  SettingsWidget({
    required this.items,
    required this.hint,
    this.cabecera,
    this.icon,
    required this.onChanged,
    this.validator,
    this.initialValue, // Parámetro adicional para el valor inicial
    Key? key,
  }) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  dynamic _currentItem;

  @override
  void initState() {
    super.initState();
    _currentItem = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<dynamic>(
      initialValue: _currentItem,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.cabecera != null)
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    widget.cabecera!,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField<dynamic>(
                  value: _currentItem,
                  hint: Text(widget.hint),
                  items: _buildDropdownMenuItems(),
                  onChanged: (value) {
                    if (widget.validator != null) {
                      state.setValue(value);
                      state.validate();
                    }
                    setState(() {
                      _currentItem = value;
                    });
                    widget.onChanged(value);
                  },
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
                    prefixIcon: widget.icon,
                  ),
                ),
              ),
              if (state.hasError)
                Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 194, 18, 18),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  List<DropdownMenuItem<dynamic>> _buildDropdownMenuItems() {
    return widget.items.map<DropdownMenuItem<dynamic>>((dynamic item) {
      return DropdownMenuItem<dynamic>(
        value: item,
        child: Text(item.name),
      );
    }).toList();
  }
}
