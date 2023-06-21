import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class CardDate extends StatelessWidget {
  final DateTime date;
  const CardDate({required this.date, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateSt = DateFormat.yMEd("ES").format(date);
    return Container(
      key: ValueKey(dateSt),
      //color: Color.fromARGB(255, 255, 255, 255),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 145, 145, 145),
          width: 1,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                size: 20,
              ),
              SizedBox(
                width: 5,
              ),
              Text("Sábado"),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            dateSt,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
