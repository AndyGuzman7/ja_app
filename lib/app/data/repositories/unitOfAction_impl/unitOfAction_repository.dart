import 'dart:ffi';

import 'package:ja_app/app/domain/models/church/church.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/user_data.dart';

abstract class UnitOfActionRepository {
  Future<List<UnitOfAction>> getUnitOfActionAll();

  Future<bool> registerUnitOfAction(
      String nameUnitOfAction, String idLeaderUnitOfAction, String idEESS);

  Future<List<UnitOfAction>> getUnitOfActionAllByEESS(String idEESS);

  Future<UnitOfAction?> getUnitOfAction(String idUnitOfAction);
  Future<List<UserData>> getMembersToUnitAction(String idUnitAction);
  Future<bool> registerMemberUnitOfAction(
      List<String> idMember, String idEESS, idUnitOfAction);

  Future<List<UserData>> getMembersEESSNoneToUnitOfAction(String idEESS);
}
