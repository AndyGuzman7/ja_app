import 'package:ja_app/app/domain/models/target_virtual/target_virtual.dart';
import 'package:ja_app/app/domain/models/user_data.dart';

abstract class TargetVirtualRepository {
  Future<bool> registerTargetVirtual(String idUnitOfAction, String idQuarter);
  Future<bool> isExistAttendanceNowByIdTrgetVirtual(
      String idTargetVirtual, DateTime dateTime);

  Future<bool> registerMemberToAttendance(
      List<Attendance> listAttendance, String idAttendaance);
  Future<bool> registerOffering(
      List<DayOffering> listOffering, String idTarget);

  Future<bool> registerAttendanceToTargetVirtual(
      DateTime dateTime, String idTargetVirtual, List<Attendance>? list);
  Future<bool> registerWhitesToTargetVirtual(
      String idTargetVirtual, double white1, double white2);

  Future<TargetVirtual?> getTargetVirtualByUnitOfAction(String idUnitOfAction);

  Future<TargetVirtual?> getTargetVirtualByUnitOfActionAndIdQuarter(
      String idUnitOfAction, String idQuarter);

  Future<TargetVirtual?> getTargetVirtual(String idTargetVirtual);
  Future<Attendance?> getAttendance(String idAttendance);

  Future<DayAtendance?> getAttendanceNowByIdTargetVirtual(
      String idTargetVirtual, DateTime dateTime);

  Future<List<DayAtendance>> getAttendanceIdTagetVirtual(
      String idTargetVirtual);

  /*Future<Attendance> getAttendance
  Future<Resources> getImagesLink();

  Future<bool> registerImageAvatar();*/
}
