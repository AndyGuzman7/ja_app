import 'package:ja_app/app/domain/models/church/church.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/user_data.dart';

import '../../../domain/models/eess/quarter.dart';

abstract class EESSRepository {
  Future<List<EESS>> getEESSAll();
  Future<EESS?> getEESS(String id);
  Future<List<UserData>> getMembersToUnitAction(
      String idUnitAction, String idEESS);
  Future<List<EESS>> getEESSByChurch(String idChurch);
  Future<bool> registerMemberEESS(String idMember, String idChurch);

  Future<bool> registerMemberEESSUnitOfAction(
      List<String> idMembers, String idEESS, idUnitOfAction);

  Future<EESS?> isExistEESSSuscripcion(String id);

  Future<EESS?> getEESSWitdhIdMember(String id);
  Future<List<UserData>> getMembersEESS(String idEESS);

  Future<List<UserData>> getMembersEESSNoneToUnitOfAction(String idEESS);

  Future<List<UserData>> getMembersChurchNoneEESS(String idEESS, idChurch);

  Future<List<UserData>> getUnitOfAction(String idEESS);
  Future<Church?> getChurchWitdhIdMember(String id);

  Future<bool> registerMembersEESS(List<String> idMembers, String idEESS);
  Future<List<Quarter>> getEESSConfigQuarter();
}
