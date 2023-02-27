import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:ja_app/app/utils/MyColors.dart';
import 'package:ja_app/app/utils/date_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../domain/models/target_virtual/target_virtual.dart';

class WidgetTableAttendance extends StatelessWidget {
  final List<UserDataAttendances> list;
  final List<DateTime> listDateTime;
  ItemScrollController _scrollController = ItemScrollController();
  WidgetTableAttendance(this.list, this.listDateTime, {Key? key})
      : super(key: key);

  card(title, subtitle) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          SizedBox(
            height: 10,
          ),
          Text(
            'Bs ' + subtitle,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  List<UserDataAttendances> orderAttendance(List<UserDataAttendances> list) {
    for (var element in list) {
      for (var date in listDateTime) {
        bool exist = element.attendance.any((element) =>
            DateController().compareTwoDates(element!.dateTime!, date));
        if (!exist) {
          element.attendance.add(Attendance(element.user.id, "N", date));
        }
      }
      element.attendance.sort((a, b) {
        return a!.dateTime!.compareTo(b!.dateTime!);
      });
    }
    return list;
  }

  List<Widget> buildItems(List<UserDataAttendances> list) {
    List<Widget> listWidget = [];
    listWidget.add(cardHeader(listDateTime));
    listWidget.addAll(list.map((e) => card2(e)).toList());
    return listWidget;
  }

  String convertDateTime(DateTime date) {
    String dateSt = DateFormat.yMEd("ES").format(date);
    return dateSt;
  }

  List<Widget> buildItemsCubeHeader(List<DateTime> list) {
    return list
        .map((e) => Container(
              height: 50,
              color: CustomColorPrimary().c,
              width: 130,
              margin: EdgeInsets.all(2),
              alignment: Alignment.center,
              child: Text(
                convertDateTime(e),
                style: TextStyle(color: Colors.white),
              ),
            ))
        .toList();
  }

  List<Widget> buildItemsCube(List<Attendance?> list) {
    return list
        .map((e) => Container(
              width: 130,
              height: 50,
              margin: EdgeInsets.all(2),
              color: colorState(e!.state),
              alignment: Alignment.center,
              child: Text(
                e.state,
                style: TextStyle(color: colorStateFont(e.state)),
              ),
            ))
        .toList();
  }

  Color colorState(String state) {
    Color color = Color.fromARGB(255, 239, 239, 239);
    color = state == "P" ? Colors.green : color;
    color = state == "F" ? Color.fromARGB(255, 236, 100, 90) : color;
    return color;
  }

  Color colorStateFont(String state) {
    Color color = Colors.black;
    color = state == "P" || state == "F" ? Colors.white : color;
    return color;
  }

  Widget card2(UserDataAttendances user) {
    List<Widget> list = [
      Container(
          width: 200,
          child: Text(
            user.user.fullName,
            style: TextStyle(fontWeight: FontWeight.w400),
          ))
    ];
    log(user.attendance.length.toString() + " " + user.user.name);
    list.addAll(buildItemsCube(user.attendance));
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      child: Row(children: list),
    );
  }

  Widget cardHeader(List<DateTime> listDateTime) {
    List<Widget> list = [
      Container(
        width: 200,
        color: Color.fromARGB(255, 249, 249, 249),
        child: Text(
          "Miembro",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      )
    ];
    list.addAll(buildItemsCubeHeader(listDateTime));
    return Container(
      color: Color.fromARGB(255, 249, 249, 249),
      child: Row(children: list),
    );
  }

  v() {
    ItemScrollController _scrollController = ItemScrollController();
    List s = buildItems(orderAttendance(list));
    ScrollablePositionedList.builder(
      itemScrollController: _scrollController,
      itemCount: s.length,
      itemBuilder: (context, index) {
        return s[index];
      },
    );

    _scrollController.scrollTo(index: 150, duration: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(221, 255, 255, 255),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: buildItems(orderAttendance(list)),
            )),
      ),
    );
  }
}
