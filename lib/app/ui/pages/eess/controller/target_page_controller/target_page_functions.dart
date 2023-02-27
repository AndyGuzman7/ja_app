import 'dart:developer';

import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/utils/date_controller.dart';

import '../../../../../data/repositories/eess_impl/eess_repository.dart';
import '../../../../../data/repositories/target_virtual/target_virtual_repository.dart';
import '../../../../../data/repositories/unitOfAction_impl/unitOfAction_repository.dart';
import '../../../../../domain/models/eess/quarter.dart';
import '../../../../../domain/models/target_virtual/target_virtual.dart';
import '../../../../../domain/models/user_data.dart';
import '../../../../gobal_widgets/dialogs/progress_dialog.dart';
import 'package:collection/collection.dart';

class TargetPageFunctions {
  final _targetVirtual = Get.find<TargetVirtualRepository>();
  final _eess = Get.find<EESSRepository>();
  final _unitOfAction = Get.find<UnitOfActionRepository>();

  Future<bool> isExistAttendance(String idTarget, DateTime date) async {
    final isExist = await _targetVirtual.isExistAttendanceNowByIdTrgetVirtual(
      idTarget,
      date,
    );
    return isExist;
  }

  Quarter? getQuarterToListQuarter(List<Quarter> listQuarter) {
    var dateTimeNow = DateTime.now();
    DateController dateController = DateController();
    Quarter? quater = listQuarter.firstWhereOrNull((element) =>
        dateController.verificationDateQuarter(
            element.startTime, element.endTime, dateTimeNow));
    return quater;
  }

  Future<DayAtendance?> getAttendanceByTargetVirtual(
      String idTarget, DateTime date) async {
    final attendance =
        await _targetVirtual.getAttendanceNowByIdTargetVirtual(idTarget, date);
    return attendance;
  }

  Future<TargetVirtual?> getTargetVirtual(String idTargetVirtual) async {
    final response = await _targetVirtual.getTargetVirtual(idTargetVirtual);
    return response;
  }

  Future<TargetVirtual?> getTargetVirtualByUnitOfAction(
      String idUnitOfAction) async {
    final response =
        await _targetVirtual.getTargetVirtualByUnitOfAction(idUnitOfAction);
    return response;
  }

  Future<TargetVirtual?> getTargetVirtualByUnitOfActionAndIdQuarter(
      String idUnitOfAction, String idQuarter) async {
    final response = await _targetVirtual
        .getTargetVirtualByUnitOfActionAndIdQuarter(idUnitOfAction, idQuarter);
    return response;
  }

  Future<bool> sendRegisterOffering(state) async {
    String? idTargetVirtual = state.targetVirtualSelected!.id;
    double? white1 = state.white1;
    double? white2 = state.white2;
    final response = await registerOffering(idTargetVirtual!, white1!, white2!);
    return response;
  }

  Future<bool> registerOffering(
      String idTargetVirtual, double white1, double white2) async {
    final response = await _targetVirtual.registerWhitesToTargetVirtual(
        idTargetVirtual, white1, white2);
    return response;
  }

  Future<bool> registerAttendanceDay(
      List<UserDataAttendance> list, String idTarget) async {
    DateTime dateNow = DateTime.now();
    bool isExist = await isExistAttendance(idTarget, dateNow);
    List<Attendance> listAttendance = list.map((e) => e.attendance).toList();

    if (!isExist) {
      final response = await _targetVirtual.registerAttendanceToTargetVirtual(
          dateNow, idTarget, null);
      if (!response) return false;
    }

    final dayAttendance = await getAttendanceByTargetVirtual(idTarget, dateNow);

    final registerMember =
        await registerAttendanceMember(listAttendance, dayAttendance!.id);
    return registerMember;
  }

  Future<bool> registerAttendanceMember(
      List<Attendance> listAttendance, String idAttendaance) async {
    final response = await _targetVirtual.registerMemberToAttendance(
        listAttendance, idAttendaance);
    return response;
  }

  Future<List<Quarter>> getListQuarter() async {
    final listQuarter = await _eess.getEESSConfigQuarter();
    return listQuarter;
  }

  List<DateTime> getDataDates(state) {
    DateController dateController = DateController();
    Quarter? quarterSelected = state.quarter;
    if (quarterSelected == null) return [];
    final listDateTime = dateController.getSaturdays(
        quarterSelected.startTime, quarterSelected.endTime);
    return listDateTime;
  }

  Quarter? getQuarterListBasedDate(List<Quarter> listQuarter, DateTime date) {
    DateController dateController = DateController();
    Quarter? quater = listQuarter.firstWhereOrNull((element) => dateController
        .verificationDateQuarter(element.startTime, element.endTime, date));
    return quater;
  }

  Future<void> onPressedButtonSave(context) async {
    ProgressDialog.show(context, double.infinity, double.infinity);
/*
    final isExist = await _targetVirtual.isExistAttendanceNowByIdTrgetVirtual(
      state.targetVirtualSelected!.id!,
      DateTime.now(),
    );

    if (isExist) {
      final attendance = await _targetVirtual.getAttendanceNowByIdTargetVirtual(
        state.targetVirtualSelected!.id!,
        DateTime.now(),
      );

      _targetVirtual.registerMemberToAttendance(
          state.listUserDataAttendance.map((e) => e.attendance).toList(),
          attendance!.id);
    } else {
      final idTargetVirtual = await _targetVirtual
          .getTargetVirtualByUnitOfAction(state.unitOfActionSelected!.id);

      _targetVirtual.registerAttendanceToTargetVirtual(
          DateTime.now(), idTargetVirtual!.id!, null);
    }
    router.pop();
    await Dialogs.alert(context,
        title: "Registro", content: "Registro exitoso");*/
  }

  Future<List<UserData>> getMembersUnitoOfAction(String idUnitOfAction) async {
    final membersUnitOfAction = await _unitOfAction.getMembersToUnitAction(
      idUnitOfAction,
    );
    return membersUnitOfAction;
  }

  Future<List<UnitOfAction>> getListUnitOfActionByEESS(String idEESS) async {
    final response = await _unitOfAction.getUnitOfActionAllByEESS(idEESS);
    return response;
  }

  Future<List<Attendance>?> getDateAttendanceList(state, DateTime dateSelected,
      String idTarget, String idUnitOfAction) async {
    bool isExist = await isExistAttendance(idTarget, dateSelected);
    bool isDayEnabled =
        DateController().compareTwoDates(dateSelected, DateTime.now());

    //if (!isExist && !isDayEnabled) return null;

    final dayAttendance =
        await getAttendanceByTargetVirtual(idTarget, dateSelected);

    if (dayAttendance == null && !isDayEnabled) {
      return null;
    }

    if (dayAttendance == null && isDayEnabled) {
      final membersUnitOfAction = await getMembersUnitoOfAction(idUnitOfAction);
      final listAttendance =
          membersUnitOfAction.map((e) => Attendance(e.id, "F", null)).toList();
      return listAttendance;
    }
    List<Attendance> listAttendance = dayAttendance!.attendance;
    final membersUnitOfAction = await getMembersUnitoOfAction(idUnitOfAction);
    var listId = membersUnitOfAction.map((e) => e.id).toList();
    listId.removeWhere(
        (element) => listAttendance.any((e) => e.idMember == element));
    final list3 = listId.map((e) => Attendance(e, "F", null)).toList();

    log(list3.length.toString());

    listAttendance.addAll(list3);

    return listAttendance;
  }
/*
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

  Future loadPageDataMain() async {
    final response = await getUnitOfActionByEESS();
    onChangedListUnitOfAction(response);
    final res =
        await getTargetVirtualByUnitOfAction(state.unitOfActionSelected!.id);
    onChangedTargetVirtualSelected(res!);
    //return response;
  }

  Future loadPageTargetVirtualData() async {
    final response =
        await getTargetVirtualByUnitOfAction(state.unitOfActionSelected!.id);
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
    var list = state.listSaturdayDateMonth;
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
    var list = state.listSaturdayDateMonth;
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
    onChangedlistSaturdayDateMonth(listDateTime);
    onChangedDateTimeSelected(listDateTime
        .firstWhere((element) => element.day >= DateTime.now().day));
    await loadDataAttendanceAction(context);
  }

  Future getOffering(String idOffering) async {
    return await _targetVirtual.getTargetVirtual(idOffering);
  }

  Future<void> loadDataSectionOffering(context) async {
    final listDateTime = getDatesNow();
    onChangedlistSaturdayDateMonth(listDateTime);
    onChangedDateTimeSelected(
      listDateTime.firstWhere((element) => element.day >= DateTime.now().day),
    );
    var list =
        await _targetVirtual.getTargetVirtual(state.targetVirtualSelected!.id!);
    if (list == null) return;

    onChangedListDayOffering(list.offeringQuarter.map((e) => e).toList());
  }

  Future<void> onPressedBtnRegisterOffering(context) async {
    ProgressDialog.show(context, double.infinity, double.infinity);
    TargetVirtual targetVirtual = state.targetVirtualSelected!;
    var dayOffering = state.dayOffering;
    var listDayOffering = state.listDayOffering;

    var r = listDayOffering
        .firstWhereOrNull((element) => element.day == dayOffering!.day);
    if (r != null) {
      listDayOffering
          .firstWhereOrNull((element) => element.day == dayOffering!.day)!
          .quatity = state.quantitiy!;
    }

    var respose = await _targetVirtual.registerOffering(
        listDayOffering, targetVirtual.id!);
    if (respose) {
      log("sssqqqqqq");
      var list = await _targetVirtual.getTargetVirtual(targetVirtual.id!);
      if (list == null) return;
      log("llega");
      onChangedListDayOffering(list.offeringQuarter.map((e) => e).toList());
    }
    router.pop();
    router.pop();
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
      state.unitOfActionSelected!.id,
    );
    if (isExist) {
      final dayAttendance =
          await _targetVirtual.getAttendanceNowByIdTargetVirtual(
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
        state.unitOfActionSelected!.id,
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

  List<DataRow> listDataRow = [];

  Future<void> loadDataSectionTargetPage() async {
    final res =
        await getTargetVirtualByUnitOfAction(state.unitOfActionSelected!.id);
    if (res == null) return;
    onChangedTargetVirtualSelected(res);

    var listQuarter = await _eess.getEESSConfigQuarter();
    onChangedListQuarter(listQuarter);

    Quarter? quater = getQuarterToListQuarter(listQuarter);
    if (!(quater == null)) onChangedQuarter(quater);

    listDataRow = await itemsTable(state.targetVirtualSelected!);
  }

  Quarter? getQuarterToListQuarter(List<Quarter> listQuarter) {
    var dateTimeNow = DateTime.now();
    Quarter? quater = listQuarter.firstWhereOrNull((element) =>
        verificationDateQuarter(
            element.startTime, element.endTime, dateTimeNow));
    return quater;
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

  List<Attendance> searchList(List<Attendance> s, String id) {
    var response = s.where((element) => element.idMember == id).toList();
    return response;
  }

  Future<List<DataRow>> itemsTable(TargetVirtual targetVirtual) async {
    var listMembers = await _unitOfAction
        .getMembersToUnitAction(state.unitOfActionSelected!.id);

    var listDayAttendance =
        await _targetVirtual.getAttendanceIdTagetVirtual(targetVirtual.id!);

    var offering = await getAttendanceAll();
    offering.sort((a, b) {
      return a.compareTo(b);
    });
    List<UserDataAttendances> listNEWW = [];

    for (var member in listMembers) {
      List<Attendance?> listss = [];
      for (var date in offering) {
        for (var dayAttendance in listDayAttendance) {
          if (date.day == dayAttendance.date.day &&
              date.month == dayAttendance.date.month) {
            for (var s in dayAttendance.attendance) {
              if (s.idMember == member.id) {
                listss.add(s);
              } else {
                listss.add(Attendance(member.id, "N"));
              }
            }
          } else {
            listss.add(Attendance(member.id, "N"));
          }
        }
      }
      listNEWW.add(UserDataAttendances(member, listss));
    }

    /*var newList = listMembers.map(((member) {
      final list = listDayAttendance
          .takeWhile(
              (value) => searchList(value.attendance, member.id).isNotEmpty)
          .toList();
      final list2 = list.map((e) => e.attendance).toList();
      final list3 = list2
          .map((e) =>
              e.firstWhereOrNull((element) => element.idMember == member.id))
          .toList();
      return UserDataAttendances(member, list3);
    })).toList();*/

    final listItems = listNEWW
        .map(
          (e) => item(e),
        )
        .toList();

    //listItems.map((e) => )
    return listItems;
  }

  DataRow item(UserDataAttendances s) {
    List<DataCell> list = [DataCell(Text(s.user.name))];
    //if (s.attendance.isNotEmpty) {
    list.addAll(s.attendance
        .map((e) => DataCell(Expanded(
              child: Container(
                  color: e!.state == "P" ? Colors.green.shade400 : null,
                  child: Text(e!.state.toString())),
            )))
        .toList());
    //}

    return DataRow(selected: true, cells: list);
  }

  Future<List<DateTime>> getAttendanceAll() async {
    var listQuarter = await _eess.getEESSConfigQuarter();

    var dateTimeNow = DateTime.now();
    Quarter? quater = listQuarter.firstWhereOrNull((element) =>
        verificationDateQuarterv2(
            element.startTime, element.endTime, dateTimeNow));
    if (quater == null) return [];

    var r = getSaturdaysv2(quater.startTime, quater.endTime);
    return r;
  }*/
}
