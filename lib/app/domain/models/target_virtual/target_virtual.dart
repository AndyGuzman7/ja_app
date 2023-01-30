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
  DateTime date;
  List<Attendance> attendance;
  DayAtendance(this.date, this.attendance);

  factory DayAtendance.fromJson(Map<String, dynamic> json) {
    return DayAtendance(
      json['date'],
      json['attendance'] != null ? List.castFrom(json['atendance']) : [],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'date': date,
        'attendance': attendance,
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
