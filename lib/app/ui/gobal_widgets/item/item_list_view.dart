import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/country.dart';
import 'package:ja_app/app/domain/models/target_virtual/target_virtual.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/item/item_list_view_controller.dart';

import '../../../utils/MyColors.dart';
import '../drop_dow/custom_dropDown.dart';

class ItemMemberV3 extends StatefulWidget {
  UserData user;
  bool isSelected;
  final void Function(UserData)? onPressed;
  ItemMemberV3(this.user, this.isSelected, this.onPressed, {Key? key})
      : super(key: key);

  @override
  State<ItemMemberV3> createState() => _ItemMemberV3State();
}

class _ItemMemberV3State extends State<ItemMemberV3> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 1, bottom: 1),
      color: Color.fromARGB(255, 255, 255, 255),
      elevation: 0,
      child: InkWell(
        //borderRadius: BorderRadius.circular(16),
        onLongPress: () {
          setState(() {
            widget.isSelected = !widget.isSelected;
            log(widget.isSelected.toString());
            widget.onPressed!(widget.user);
          });
        },
        //router.pushNamed(pageRoute);

        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                width: 30,
                height: 30,
                child: Container(
                  child: CircleAvatar(
                    child: Image.network(widget.user.photoURL),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name + " " + widget.user.lastName,
                    style: TextStyle(fontSize: 14),
                  ),
                  /*Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        user.email + " " + user.lastName,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 123, 123, 123)),
                      )),
                  Text(
                    "Usuario registrado",
                    style: TextStyle(color: Color.fromARGB(255, 13, 97, 167)),
                  )*/
                ],
              ),
            ),
            if (widget.isSelected)
              Icon(Icons.check_box_outlined)
            else
              Icon(Icons.check_box_outline_blank_rounded)
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemMemberV4 extends StatefulWidget {
  UserData user;
  Attendance attendance;
  bool isSelected;

  final void Function(UserData userData, Attendance state)? onPressed;
  ItemMemberV4(this.user, this.attendance, this.isSelected, this.onPressed,
      {Key? key})
      : super(key: key);

  @override
  State<ItemMemberV4> createState() => _ItemMemberV4State();
}

class _ItemMemberV4State extends State<ItemMemberV4> {
  String? value;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 1, bottom: 1),
      color: Color.fromARGB(255, 255, 255, 255),
      elevation: 0,
      child: InkWell(
        //borderRadius: BorderRadius.circular(16),
        onLongPress: () {
          setState(() {
            widget.isSelected = !widget.isSelected;
            log(widget.isSelected.toString());
            widget.onPressed!(widget.user, Attendance(widget.user.id, value!));
          });
        },
        //router.pushNamed(pageRoute);

        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                width: 30,
                height: 30,
                child: Container(
                  child: CircleAvatar(
                    child: Image.network(widget.user.photoURL),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name + " " + widget.user.lastName,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20, left: 10),
              child: PopupMenuButton(
                constraints: BoxConstraints(),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: Color.fromARGB(255, 146, 146, 146))),
                  child: Row(
                    children: [
                      Container(
                        height: 48,
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Text(widget.attendance.state),
                            Icon(
                              Icons.filter_list_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                            Icon(
                              Icons.arrow_drop_down_sharp,
                              color: Colors.black,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                itemBuilder: (ctx) => [
                  _buildPopupMenuItem('P'),
                  _buildPopupMenuItem('F'),
                ],
              ),
            ),
            /*if (widget.isSelected)
              Icon(Icons.check_box_outlined)
            else
              Icon(Icons.check_box_outline_blank_rounded)*/
          ],
        ),
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(
      child: Text(title),
      onTap: () {
        setState(() {
          value = title;
        });
        widget.onPressed!(widget.user, Attendance(widget.user.id, value!));
        //eeSsProvider.read.onChangedTitleSearch(title);
      },
    );
  }
}
