import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/data/repositories/eess_impl/eess_repository.dart';
import 'package:ja_app/app/data/repositories/unitOfAction_impl/unitOfAction_repository.dart';
import 'package:ja_app/app/data/repositories/user_impl/user_repository.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/quarter.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/target_virtual/target_virtual.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/dialogs.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/progress_dialog.dart';
import 'package:ja_app/app/ui/pages/eess/controller/eess_controller.dart';
import 'package:ja_app/app/ui/pages/eess/controller/members_page_controller/members_page_state.dart';
import 'package:ja_app/app/ui/pages/eess/controller/target_page_controller/target_page_state.dart';
import 'package:ja_app/app/ui/pages/eess/eess_page.dart';
import 'package:collection/collection.dart';
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
    ProgressDialog.show(context, double.infinity, double.infinity);

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
    ProgressDialog.show(context, double.infinity, double.infinity);
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

  void onChangedListUserDataAttendance(List<UserDataAttendance> list) {
    state = state.copyWith(listUserDataAttendance: list);
  }

  void onChangedListDateTimeMonth(list) {
    state = state.copyWith(listDateTimeMonth: list);
  }

  void onChangedDateTimeSelected(DateTime dateTime) {
    state = state.copyWith(dateTimeSelected: dateTime);
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
    attendanceList.where((element) => element.idMember == idMember);

    onChangedAttendaceList(attendanceList);
  }

  void onChangedQuarter(Quarter quarter) {
    state = state.copyWith(quarter: quarter);
  }

  void onChangedListQuarter(List<Quarter> listQuarter) {
    state = state.copyWith(listQuarter: listQuarter);
  }

  void changedStateUserDataAttendance(UserDataAttendance userDataAttendance) {
    List<Attendance> attendanceList = state.attendanceList;
    attendanceList
        .where((element) => element.idMember != userDataAttendance.user.id)
        .toList()
        .add(userDataAttendance.attendance);

    onChangedAttendaceList(attendanceList);
  }

  Future<void> onPressedButtonSave(context) async {
    ProgressDialog.show(context, double.infinity, double.infinity);

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
          state.listUserDataAttendance.map((e) => e.attendance).toList(),
          attendance!.id);
    } else {
      final idTargetVirtual = await _targetVirtual
          .getTargetVirtualByUnitOfAction(state.unitOfAction!.id);

      _targetVirtual.registerAttendanceToTargetVirtual(
          DateTime.now(), idTargetVirtual!.id!, state.attendanceList);
    }
    router.pop();
    await Dialogs.alert(context,
        title: "Registro", content: "Registro exitoso");
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

  Future<void> onPressedNextDateTime(context) async {
    var list = state.listDateTimeMonth;
    var dateTime = state.dateTimeSelected;
    var index = list!.indexWhere((element) => element.day == dateTime!.day);
    var indexNow = index + 1;
    if (indexNow < list.length) {
      onChangedDateTimeSelected(list[indexNow]);
      onChangedListUserDataAttendance([]);
      await loadDataAttendanceAction(context);
    }
  }

  Future<void> onPressedLastDateTime(context) async {
    var list = state.listDateTimeMonth;
    var dateTime = state.dateTimeSelected;
    var index = list!.indexWhere((element) => element.day == dateTime!.day);
    var indexNow = index - 1;
    if (indexNow >= 0) {
      onChangedDateTimeSelected(list[indexNow]);
      onChangedListUserDataAttendance([]);
      await loadDataAttendanceAction(context);
    }
  }

  Future<void> initPageAttedanceAction(context) async {
    final listDateTime = getDatesNow();
    onChangedListDateTimeMonth(listDateTime);
    onChangedDateTimeSelected(listDateTime
        .firstWhere((element) => element.day >= DateTime.now().day));
    await loadDataAttendanceAction(context);
  }

  Future<void> loadDataAttendanceAction(context) async {
    if (state.dateTimeSelected!.day > DateTime.now().day) {
      onChangedListUserDataAttendance([]);
      return;
    }

    final isExist = await _targetVirtual.isExistAttendanceNowByIdTrgetVirtual(
      state.targetVirtualSelected!.id!,
      state.dateTimeSelected!,
    );
    final membersUnitOfAction = await _unitOfAction.getMembersToUnitAction(
      state.unitOfAction!.id,
    );
    if (isExist) {
      final dayAttendance =
          await _targetVirtual.getAttendanceNowByIdTrgetVirtual(
        state.targetVirtualSelected!.id!,
        state.dateTimeSelected!,
      );

      final listIdMembers = membersUnitOfAction.map((e) => e.id).toList();
      List<Attendance> listAttendance = dayAttendance!.attendance;
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

      onChangedListUserDataAttendance(usersData);
      onChangedAttendaceList(usersData.map((e) => e.attendance).toList());
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

  List<DateTime> getDatesNow() {
    final dateNow = DateTime.now();
    final dayMonth = DateTime(dateNow.year, dateNow.month + 1, -1).day + 1;

    var daysMonth = List.generate(dayMonth, (number) => number + 1);

    var daysSaturday = daysMonth.where((element) =>
        DateTime(dateNow.year, dateNow.month, element).weekday == 6);
    var dateSaturday = daysSaturday
        .map((e) => DateTime(dateNow.year, dateNow.month, e))
        .toList();

    return dateSaturday;
  }

  List<DateTime> getDatesNowV2(DateTime dte) {
    final dateNow = dte;
    final dayMonth = DateTime(dateNow.year, dateNow.month + 1, -1).day + 1; //31
    final daysMin = (dayMonth - dateNow.day) + 1;

    var daysMonth = List.generate(daysMin, (number) => dayMonth - number);

    var daysSaturday = daysMonth.where((element) =>
        DateTime(dateNow.year, dateNow.month, element).weekday == 6);
    var dateSaturday = daysSaturday
        .map((e) => DateTime(dateNow.year, dateNow.month, e))
        .toList();

    return dateSaturday;
  }

  getSaturdays(start, end) {
    var list = getMonthsInTheDates(start, end);
    print(list);
    List<DateTime> listNew = [];
    for (var element in list) {
      listNew.addAll(getDatesNowV2(element));
    }
    print(start);
    print(end);
    print(listNew);

    listNew =
        listNew.where((e) => verificationDateQuarter(start, end, e)).toList();
    print(listNew);
  }

  Widget willPopScope({bool isColorBackground = true}) {
    return WillPopScope(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: isColorBackground
            ? const Color.fromARGB(255, 255, 255, 255)
            : Colors.transparent,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: !isColorBackground ? Colors.white : null,
        ),
      ),
      onWillPop: () async => false,
    );
  }

  getAttendanceAll() async {
    var listQuarter = await _eess.getEESSConfigQuarter();
    onChangedListQuarter(listQuarter);
    var dateTimeNow = DateTime.now();
    Quarter? quater = listQuarter.firstWhereOrNull((element) =>
        verificationDateQuarter(
            element.startTime, element.endTime, dateTimeNow));
    if (quater == null) return;
    onChangedQuarter(quater);
    getSaturdays(quater.startTime, quater.endTime);
  }

  List<DateTime> getMonthsInTheDates(DateTime start, DateTime end) {
    List<DateTime> listDateTimes = [];
    bool isok = false;
    int month = start.month;
    int year = start.year;
    int day = 1;
    while (!isok) {
      if (month == end.month && year == end.year) {
        isok = true;
      }
      listDateTimes.add(DateTime(year, month, day));

      if (month == 12) {
        month = 0;
        year++;
      }
      month++;
    }
    return listDateTimes;
  }

  verificationDateQuarter(
      DateTime startTimeDate, DateTime endTimeDate, DateTime dateComparation) {
    startTimeDate = DateTime(
        startTimeDate.year, startTimeDate.month, startTimeDate.day - 1);
    endTimeDate =
        DateTime(endTimeDate.year, endTimeDate.month, endTimeDate.day + 1);

    var d = startTimeDate.isBefore(dateComparation) &&
        endTimeDate.isAfter(dateComparation);

    return d;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
