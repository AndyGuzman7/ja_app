import 'package:ja_app/app/domain/models/church/church.dart';

abstract class ChurchRepository {
  Future<bool> registerMemberChurch(String idMember, String idChurch);

  Future<bool> registerMemberChurchCodeAcess(String idMember, String code);
  Future<Church?> isExistChurchCodeAccess(String code);
  Future<Church?> isExistChurchSuscripcion(String id);
  Future<Church?> getChurchWitdhIdMember(String id);
}
