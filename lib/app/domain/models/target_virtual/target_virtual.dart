import 'dart:developer';

import '../user_data.dart';

class TargetVirtual {
  final String? id;
  final String idUnitOfAction;
  final List<DayAtendance>? attendance;

  TargetVirtual(
    this.id,
    this.idUnitOfAction,
    this.attendance,
  );

  factory TargetVirtual.fromJson(Map<String, dynamic> json) {
    return TargetVirtual(
      json['id'],
      json['idUnitOfAction'],
      json['attendance'] != null ? List.castFrom(json['attendance']) : [],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'idUnitOfAction': idUnitOfAction,
        'attendance': attendance,
      };
}

class DayAtendance {
  String id;
  String idTargetVirtual;
  DateTime date;
  List<Attendance> attendance;
  DayAtendance(this.id, this.idTargetVirtual, this.date, this.attendance);

  factory DayAtendance.fromJson(Map<String, dynamic> json) {
    convert(date) {
      DateTime dateTime = date.toDate();
      return dateTime;
    }

    List<Attendance> convertList(List json) {
      log(json.toString());
      // Map<String, dynamic> jsons = json;
      List<Attendance> list = [];
      //json.map((key, value) => null)
      for (var element in json) {
        list.add(Attendance.fromJson(element));
      }

      /*json.forEach((value) {
        list.add(UnitOfAction.fromJson(value));
        //print('$value');
        //listBrochures.add(Brochure.fromJson(value));
      });*/
      return list;
    }

    return DayAtendance(
      json['id'],
      json['idTargetVirtual'],
      convert(json['date']),
      json['attendance'] != null
          ? convertList(List.castFrom(json['attendance']))
          : [],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'idTargetVirtual': idTargetVirtual,
        'date': date,
        'attendance': attendance.map((e) => e.toJson()).toList(),
      };
}

class Attendance {
  String idMember;
  String state;
  Attendance(this.idMember, this.state);

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(json['idMember'], json['state']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'idMember': idMember,
        'state': state,
      };
}

class UserDataAttendance {
  UserData user;
  Attendance attendance;
  UserDataAttendance(this.user, this.attendance);
}
