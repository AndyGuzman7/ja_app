import 'package:cloud_firestore/cloud_firestore.dart';

class Quarter {
  String id;
  String name;
  DateTime endTime;
  DateTime startTime;
  Quarter(this.id, this.name, this.endTime, this.startTime);
  factory Quarter.fromJson(Map<String, dynamic> json) {
    convert(Timestamp date) {
      DateTime dateTime =
          DateTime(date.toDate().year, date.toDate().month, date.toDate().day);
      return dateTime;
    }

    return Quarter(
      json['id'],
      json['name'],
      convert(json['end_time']),
      convert(json['start_time']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'end_time': endTime,
        'start_time': startTime,
      };
}
