import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  List<dynamic> lisItems;
  final String? Function(dynamic)? validator;
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
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState<T> extends State<CustomDropDown> {
  dynamic value;
  @override
  Widget build(BuildContext context) {
    return FormField<dynamic>(
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
                    value: value,
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
                      if (text != null) {
                        setState(() {
                          value = text;
                          widget.onChanged(text);
                        });
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

class SettingsWidget extends StatefulWidget {
  List items;

  final String? Function(dynamic)? validator;
  final String hint;
  final Icon? icon;
  void Function(dynamic) onChanged;
  SettingsWidget({
    required this.items,
    required this.onChanged,
    this.icon,
    required this.validator,
    required this.hint,
    Key? key,
  }) : super(key: key);

  @override
  _SettingsWidgetState createState() => new _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  List<DropdownMenuItem<dynamic>>? dropDownMenuItems;
  dynamic currentItem;

  @override
  void initState() {
    dropDownMenuItems = getDropDownMenuItem();
    currentItem = dropDownMenuItems![0].value;
    widget.onChanged(currentItem);

    super.initState();
  }

  List<DropdownMenuItem<dynamic>> getDropDownMenuItem() {
    List<DropdownMenuItem<dynamic>> items = [];
    for (dynamic item in widget.items) {
      items.add(DropdownMenuItem(value: item, child: Text(item.name)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<dynamic>(
      initialValue: null,
      //validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  widget.hint,
                  style: const TextStyle(fontSize: 17),
                ),
              ),
              ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField<dynamic>(
                  value: currentItem,
                  items: dropDownMenuItems,
                  onChanged: (value) {
                    if (widget.validator != null) {
                      state.setValue(value);
                      state.validate();
                    }

                    if (value != null) {
                      widget.onChanged(value);
                      setState(() {
                        currentItem = value;
                      });
                    }
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
                    prefixIcon: widget.icon != null
                        ? Icon(
                            widget.icon!.icon,
                            color: Colors.black,
                          )
                        : null,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void changedDropDownItems(dynamic selectedItem) {
    setState(() {
      currentItem = selectedItem;
    });
  }
}


/**
 * 
 * 
 * 
 * 
class SettingsWidget extends StatefulWidget {
  SettingsWidget({Key? key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => new _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  List _cities = [
    "Cluj-Napoca",
    "Bucuresti",
    "Timisoara",
    "Brasov",
    "Constanta"
  ];

  List<DropdownMenuItem<String>>? _dropDownMenuItems;
  String? _currentCity;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems![0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String city in _cities) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Center(
          child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text("Please choose your city: "),
          new Container(
            padding: new EdgeInsets.all(16.0),
          ),
          new DropdownButton(
            value: _currentCity,
            items: _dropDownMenuItems,
            onChanged: changedDropDownItem,
          )
        ],
      )),
    );
  }

  void changedDropDownItem(String? selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }
}

 * 
 * 
 * 
 */