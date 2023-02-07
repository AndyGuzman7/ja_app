import 'dart:developer';

import '../user_data.dart';

class TargetVirtual {
  final String? id;
  final String idUnitOfAction;
  final List<DayAtendance>? attendance;
  final List<DayOffering> offeringQuarter;
  final String idQuarter;

  TargetVirtual(this.id, this.idUnitOfAction, this.attendance,
      this.offeringQuarter, this.idQuarter);

  factory TargetVirtual.fromJson(Map<String, dynamic> json) {
    return TargetVirtual(
        json['id'],
        json['idUnitOfAction'],
        json['attendance'] != null ? List.castFrom(json['attendance']) : [],
        json['offeringQuarter'] != null
            ? List.castFrom(json['offeringQuarter'])
            : [],
        json['idQuarter']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'idUnitOfAction': idUnitOfAction,
        'attendance': attendance,
        'idQuarter': idQuarter,
        'offeringQuarter': offeringQuarter
      };
}

class DayOffering {
  double quatity;
  DateTime date;
  int day;
  DayOffering(this.quatity, this.date, this.day);
  factory DayOffering.fromJson(Map<String, dynamic> json) {
    convert(date) {
      DateTime dateTime = date.toDate();
      return dateTime;
    }

    return DayOffering(json['quantity'], convert(json['date']), json['day']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'quantity': quatity,
        'date': date,
        'day': day,
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
