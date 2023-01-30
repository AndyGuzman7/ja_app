import 'package:ja_app/app/domain/models/target_virtual/target_virtual.dart';

abstract class TargetVirtualRepository {
  Future<bool> registerTargetVirtual(String idUnitOfAction);
  Future<bool> isExistAttendanceNowByIdUnitfAction(String idUnitOfAction);
  Future<bool> registerAttendanceToTargetVirtual(
      DateTime dateTime, String idTargetVirtual);

  Future<TargetVirtual?> getTargetVirtualByUnitOfAction(String idUnitOfAction);
  /*Future<Attendance> getAttendance
  Future<Resources> getImagesLink();

  Future<bool> registerImageAvatar();*/
}
