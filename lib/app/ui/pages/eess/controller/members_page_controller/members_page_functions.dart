import 'dart:developer';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import '../../../../../data/repositories/church_repository/church_repository.dart';
import '../../../../../data/repositories/eess_repository/eess_repository.dart';
import '../../../../../data/repositories/unitOfAction_repository/unitOfAction_repository.dart';
import '../../../../../domain/models/user_data.dart';
import '../eess_controller.dart';

class MembersPageFunctions {
  final _eess = Get.find<EESSRepository>();
  final _unitOfAction = Get.find<UnitOfActionRepository>();
  final _church = Get.find<ChurchRepository>();

  final EeSsController _eeSsController;
  MembersPageFunctions(this._eeSsController);

  Future<bool> registerMembersToEESS(List<String> list) async {
    final idEESS = _eeSsController.state.eess!.id;
    final response = await _eess.registerMembersEESS(list, idEESS!);
    return response;
  }

  registerMembersToChurch(String idMember) async {
    final idEESS = _eeSsController.state.eess!.id;
    final idChurch = await _church.getChurchByEESS(idEESS!);

    final response = await _church.registerMemberChurch(idMember, idChurch!.id);
    return response;
  }

  createMemberToEESS(UserData userData) async {
    final responseChurch = await registerMembersToChurch(userData.id);

    if (!responseChurch) return false;
    final response = await registerMembersToEESS([userData.id]);

    if (!response) return false;
    return response;
  }

  closePage() {
    router.pop();
  }

  Future<List<UserData>> getListMembers() async {
    List<UserData> listUserData = [];
    listUserData = await _eess.getMembersEESS(_eeSsController.state.eess!.id!);
    return listUserData;
  }

  Future<List<UserData>> getUnitOfAction() async {
    List<UserData> listUserData = [];
    listUserData = await _eess.getMembersEESS(_eeSsController.state.eess!.id!);
    return listUserData;
  }

  Future<List<UserData>> getMembersEESS() async {
    final idEESS = _eeSsController.state.eess!.id;
    final response = await _eess.getMembersEESS(idEESS!);
    return response;
  }

  Future<List<UserData>>? getMembersNoneEESS() async {
    final idEESS = _eeSsController.state.eess!.id;
    final response = await _eess.getMembersChurchNoneEESS(
        idEESS!, _eeSsController.state.church!.id);
    return response;
  }

  Future loadPageData() async {
    final response = await getMembersEESS();
    //onChangedMembersEESS(response);
  }
}
