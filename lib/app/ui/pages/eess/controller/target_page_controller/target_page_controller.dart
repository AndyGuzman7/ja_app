import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/data/repositories/eess_impl/eess_repository.dart';
import 'package:ja_app/app/data/repositories/unitOfAction_impl/unitOfAction_repository.dart';
import 'package:ja_app/app/data/repositories/user_impl/user_repository.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/target_virtual/target_virtual.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/dialogs.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/progress_dialog.dart';
import 'package:ja_app/app/ui/pages/eess/controller/eess_controller.dart';
import 'package:ja_app/app/ui/pages/eess/controller/members_page_controller/members_page_state.dart';
import 'package:ja_app/app/ui/pages/eess/controller/target_page_controller/target_page_state.dart';
import 'package:ja_app/app/ui/pages/eess/eess_page.dart';

import 'package:ja_app/app/ui/routes/routes.dart';

import '../../../../../data/repositories/target_virtual/target_virtual_repository.dart';
import '../../../../global_controllers/session_controller.dart';

final targetPageProvider = StateProvider<TargetPageController, TargetPageState>(
    (_) => TargetPageController(sessionProvider.read, eeSsProvider.read),
    autoDispose: true);

class TargetPageController extends StateNotifier<TargetPageState> {
  final SessionController _sessionController;
  final EeSsController _eeSsController;
  List<UserData> membersSelected = [];
  String? _routeName;
  String? get routeName => _routeName;
  final userRepository = Get.find<UserRepository>();

  final GlobalKey<FormState> formKey = GlobalKey();

  final GlobalKey formKey2 = GlobalKey();

  final GlobalKey<FormState> formKeyRegisterUnitOfAction = GlobalKey();

  final _targetVirtual = Get.find<TargetVirtualRepository>();
  final _eess = Get.find<EESSRepository>();
  final _unitOfAction = Get.find<UnitOfActionRepository>();
  TargetPageController(this._sessionController, this._eeSsController)
      : super(TargetPageState.initialState);

  onPressedRegisterUnitOfAction(context) async {
    final isReady = formKeyRegisterUnitOfAction.currentState;

    if (isReady != null) {
      final validator = formKeyRegisterUnitOfAction.currentState!.validate();
      if (validator) {
        await registerUnitOfAction(context);
        router.pop(context);
      }
    }
  }

  Future registerUnitOfAction(context) async {
    ProgressDialog.show(context);

    final response = await _unitOfAction.registerUnitOfAction(
        state.nameUnitOfActionCreate!,
        state.userDataUnitOfActionCreate!.id,
        _eeSsController.state.eess!.id!);
    router.pop(context);

    if (response != null) {
      await Dialogs.alert(context,
          title: "Registro", content: "Registro exitoso");
      await loadPageData();
    } else {
      Dialogs.alert(context, title: "Invalido", content: "Codigo invalido");
    }
  }

  onChangedListMembersSelected(UserData user) {
    List<UserData> list = state.membersEESSNew;
    list.contains(user)
        ? removeListMembersSelected(user)
        : addListMembersSelected(user);
  }

  onPressedAddMembers(context) async {
    ProgressDialog.show(context);
    final List<UserData> list = state.membersEESSNew;

    List<String> listIdS = [];
    for (var element in list) {
      listIdS.add(element.id);
    }
    final idEess = _eeSsController.state.eess!.id;

    final response = await _eess.registerMembersEESS(listIdS, idEess!);

    if (response) {
      state = state.copyWith(membersEESSNew: []);
      await loadPageData();
    }
    router.pop(context);
  }

  addListMembersSelected(UserData user) {
    List<UserData> list = state.membersEESSNew;
    list.add(user);
    state = state.copyWith(membersEESSNew: list);
  }

  removeListMembersSelected(UserData user) {
    List<UserData> list = state.membersEESSNew;
    list.remove(user);
    state = state.copyWith(membersEESSNew: list);
  }

  void onChangedUnitOfAction(UnitOfAction unitOfAction) {
    state = state.copyWith(unitOfAction: unitOfAction);
  }

  void onChangedListUnitOfAction(List<UnitOfAction> list) {
    state = state.copyWith(listUnitOfAction: list);
    if (list.isNotEmpty) {
      onChangedUnitOfAction(list.first);
    }
  }

  void onChangedNameCreateUnitOfAction(String name) {
    state = state.copyWith(nameUnitOfActionCreate: name);
  }

  void onChangedUserDateCreateUnitOfAction(UserData user) {
    state = state.copyWith(userDataUnitOfActionCreate: user);
  }

  void onChangedMembersUnitOfAction(list) {
    state = state.copyWith(membersUnitOfAction: list);
  }

  void onChangedListUserDataAttendance(list) {
    state = state.copyWith(listUserDataAttendance: list);
  }

  void onChangedAttendaceList(list) {
    state = state.copyWith(attendanceList: list);
  }

  void onChangedTargetVirtualSelected(TargetVirtual targetVirtual) {
    state = state.copyWith(targetVirtualSelected: targetVirtual);
  }

  void onChangedListAttendance(List<UserData> list) {
    state = state.copyWith(membersAttendance: list);
  }

  void changedStateMember(String idMember, Attendance stateMember) {
    List<Attendance> attendanceList = state.attendanceList;
    final r = attendanceList.where((element) => element.idMember == idMember);

    if (r.isNotEmpty) {
      attendanceList
          .where((element) => element.idMember == idMember)
          .first
          .state = stateMember.state;
    }
    onChangedAttendaceList(attendanceList);
  }

  Future<void> onPressedButtonSave() async {
    final isExist = await _targetVirtual.isExistAttendanceNowByIdTrgetVirtual(
      state.targetVirtualSelected!.id!,
      DateTime.now(),
    );

    if (isExist) {
      final attendance = await _targetVirtual.getAttendanceNowByIdTrgetVirtual(
        state.targetVirtualSelected!.id!,
        DateTime.now(),
      );

      _targetVirtual.registerMemberToAttendance(
          state.attendanceList, attendance!.id);
    } else {
      final idTargetVirtual = await _targetVirtual
          .getTargetVirtualByUnitOfAction(state.unitOfAction!.id);

      _targetVirtual.registerAttendanceToTargetVirtual(
          DateTime.now(), idTargetVirtual!.id!, state.attendanceList);
    }
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

  Future<List<UserData>>? getMembersToUnitOfAction(String idUnitAction) async {
    final response = await _unitOfAction.getMembersToUnitAction(idUnitAction);
    onChangedMembersUnitOfAction(response);
    //onChangedListMembersUnitOfAction(response);

    return response;
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

  Future<List<UnitOfAction>> getUnitOfActionByEESS() async {
    final idEESS = _eeSsController.state.eess!.id;
    final unitOfActions = await _unitOfAction.getUnitOfActionAllByEESS(idEESS!);
    return unitOfActions;
  }

  /* Future loadPageData() async {
    final response = await getMembersEESS();
    onChangedMembersEESS(response);
  }*/

  Future loadPageData() async {
    final response = await getUnitOfActionByEESS();
    onChangedListUnitOfAction(response);
    final res = await getTargetVirtualByUnitOfAction(state.unitOfAction!.id);
    onChangedTargetVirtualSelected(res!);
    //return response;
  }

  Future loadPageTargetVirtualData() async {
    final response =
        await getTargetVirtualByUnitOfAction(state.unitOfAction!.id);
    onChangedTargetVirtualSelected(response!);
  }

  Future<TargetVirtual?> getTargetVirtualByUnitOfAction(
      String idUnitOfAction) async {
    final targetVirtual =
        await _targetVirtual.getTargetVirtualByUnitOfAction(idUnitOfAction);
    return targetVirtual;
  }

  /*void onChangedMembersEESS(List<UserData> list) {
    state = state.copyWith(membersEESS: list);
  }*/

  Future<void> loadDataAttendanceAction() async {
    final isExist = await _targetVirtual.isExistAttendanceNowByIdTrgetVirtual(
      state.targetVirtualSelected!.id!,
      DateTime.now(),
    );
    log(isExist.toString());
    if (isExist) {
      final membersUnitOfAction = await _unitOfAction.getMembersToUnitAction(
        state.unitOfAction!.id,
      );

      DayAtendance? attendance =
          await _targetVirtual.getAttendanceNowByIdTrgetVirtual(
        state.targetVirtualSelected!.id!,
        DateTime.now(),
      );

      final listIdMembers = membersUnitOfAction.map((e) => e.id).toList();

      List<Attendance> listAttendance = attendance!.attendance;
      for (var element in listAttendance) {
        if (listIdMembers.contains(element.idMember)) {
          listIdMembers.remove(element.idMember);
        }
      }
      listAttendance.addAll(listIdMembers.map((e) => Attendance(e, "F")));

      final listUsers = await userRepository
          .getMembersToIds(listAttendance.map((e) => e.idMember).toList());

      List<UserDataAttendance> usersData = listAttendance.map(((e) {
        final user = listUsers.firstWhere(
          (element) => element.id == e.idMember,
        );
        return UserDataAttendance(user, e);
      })).toList();
      log(usersData.length.toString());
      onChangedListUserDataAttendance(usersData);
      onChangedMembersUnitOfAction(listUsers);
      onChangedAttendaceList(listAttendance);
    } else {
      final membersUnitOfAction = await _unitOfAction.getMembersToUnitAction(
        state.unitOfAction!.id,
      );

      final listAttendance =
          membersUnitOfAction.map((e) => Attendance(e.id, "F")).toList();

      List<UserDataAttendance> usersData = listAttendance.map(((e) {
        final user = membersUnitOfAction.firstWhere(
          (element) => element.id == e.idMember,
        );
        return UserDataAttendance(user, e);
      })).toList();
      log(usersData.length.toString());
      onChangedListUserDataAttendance(usersData);

      onChangedAttendaceList(
          membersUnitOfAction.map((e) => Attendance(e.id, "F")).toList());
      onChangedMembersUnitOfAction(membersUnitOfAction);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
