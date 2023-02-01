import 'package:ja_app/app/domain/models/target_virtual/target_virtual.dart';
import 'package:ja_app/app/domain/models/user_data.dart';

abstract class TargetVirtualRepository {
  Future<bool> registerTargetVirtual(String idUnitOfAction);
  Future<bool> isExistAttendanceNowByIdTrgetVirtual(
      String idTargetVirtual, DateTime dateTime);

  Future<bool> registerMemberToAttendance(
      List<Attendance> listAttendance, String idAttendaance);

  Future<bool> registerAttendanceToTargetVirtual(
      DateTime dateTime, String idTargetVirtual, List<Attendance>? list);

  Future<TargetVirtual?> getTargetVirtualByUnitOfAction(String idUnitOfAction);

  Future<TargetVirtual?> getTargetVirtual(String idTargetVirtual);
  Future<Attendance?> getAttendance(String idAttendance);

  Future<DayAtendance?> getAttendanceNowByIdTrgetVirtual(
      String idTargetVirtual, DateTime dateTime);

  /*Future<Attendance> getAttendance
  Future<Resources> getImagesLink();

  Future<bool> registerImageAvatar();*/
}
