import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/item/item_list_view_controller.dart';

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
