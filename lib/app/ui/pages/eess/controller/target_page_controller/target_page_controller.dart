import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/data/repositories/eess_impl/eess_repository.dart';
import 'package:ja_app/app/data/repositories/unitOfAction_impl/unitOfAction_repository.dart';
import 'package:ja_app/app/data/repositories/user_impl/user_repository.dart';
import 'package:ja_app/app/domain/models/eess/quarter.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/target_virtual/target_virtual.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/dialogs.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/progress_dialog.dart';
import 'package:ja_app/app/ui/pages/eess/controller/eess_controller.dart';
import 'package:ja_app/app/ui/pages/eess/controller/members_page_controller/members_page_controller.dart';
import 'package:ja_app/app/ui/pages/eess/controller/target_page_controller/target_page_functions.dart';
import 'package:ja_app/app/ui/pages/eess/controller/target_page_controller/target_page_state.dart';
import 'package:ja_app/app/ui/pages/eess/eess_page.dart';
import 'package:collection/collection.dart';
import 'package:ja_app/app/ui/pages/eess/widgets/unit_page_eess.dart';
import 'package:ja_app/app/utils/date_controller.dart';
import '../../../../../data/repositories/target_virtual/target_virtual_repository.dart';
import '../../../../global_controllers/session_controller.dart';

final targetPageProvider = StateProvider<TargetPageController, TargetPageState>(
    (_) => TargetPageController(sessionProvider.read, eeSsProvider.read),
    autoDispose: true);

class TargetPageController extends StateNotifier<TargetPageState> {
  final SessionController sessionController;
  final EeSsController _eeSsController;
  final GlobalKey<FormState> formKeyOfferingWhites = GlobalKey();

  final GlobalKey<FormState> formKeyOffering = GlobalKey();
  final GlobalKey<FormState> formKeyAttendance = GlobalKey();
  final TargetPageFunctions targetPageFunctions = TargetPageFunctions();
  final _targetVirtual = Get.find<TargetVirtualRepository>();
  TargetPageController(this.sessionController, this._eeSsController)
      : super(TargetPageState.initialState);

  initPageMain() async {
    String? idEESS = _eeSsController.state.eess!.id;
    final response =
        await targetPageFunctions.getListUnitOfActionByEESS(idEESS!);
    onChangedListUnitOfAction(response);
    if (response.isNotEmpty) {
      onChangedUnitOfActionSelected(response.first);
    }
  }

  initPageSectionTargetVirtual() async {
    String idUnitOfdAction = state.unitOfActionSelected!.id;
    var listQuarter = await targetPageFunctions.getListQuarter();
    onChangedListQuarter(listQuarter);

    Quarter? quater = targetPageFunctions.getQuarterToListQuarter(listQuarter);
    if (!(quater == null)) onChangedQuarter(quater);
    final res =
        await targetPageFunctions.getTargetVirtualByUnitOfActionAndIdQuarter(
            idUnitOfdAction, quater!.id);
    if (res == null) return;
    onChangedTargetVirtualSelected(res);
  }

  Future<void> initDialogShowAttendance(context) async {
    //loadDates();
    await loadDataDialogShowAttendance(context);
  }

  Future<void> loadDataUnitOfferingSection(context) async {
    loadDates();
    String? idTargetVirtual = state.targetVirtualSelected!.id;
    final targetVirtual =
        await targetPageFunctions.getTargetVirtual(idTargetVirtual!);
    if (targetVirtual == null) return;

    onChangedTargetVirtualSelected(targetVirtual);

    onChangedOnWhite1(targetVirtual.whiteTSOffering);
    onChangedWhite2(targetVirtual.whiteWeeklyOffering);

    onChangedListDayOffering(
        targetVirtual.offeringQuarter.map((e) => e).toList());
  }

  Future<void> loadDataUnitAttendanceSection(context) async {
    //loadDates();
    String? idTargetVirtual = state.targetVirtualSelected!.id;
    final targetVirtual =
        await targetPageFunctions.getTargetVirtual(idTargetVirtual!);
    if (targetVirtual == null) return;

    onChangedTargetVirtualSelected(targetVirtual);

    await loadTableAttendance();
  }

  Future<void> loadTableAttendance() async {
    await itemsTable(state.targetVirtualSelected!);
  }

  Future<void> loadDataDialogShowAttendance(context) async {
    List<UserDataAttendance>? usersData = [];

    String idUnitOfAction = state.unitOfActionSelected!.id;
    DateTime? dateSelected = state.dateTimeSelected;
    String? idTarget = state.targetVirtualSelected!.id;

    List<Attendance>? listAttendance = await targetPageFunctions
        .getDateAttendanceList(state, dateSelected!, idTarget!, idUnitOfAction);

    if (listAttendance != null) {
      List<UserData> listMembers =
          await targetPageFunctions.getMembersUnitoOfAction(idUnitOfAction);
      usersData = listAttendance.map(((e) {
        final user = listMembers.firstWhere(
          (element) => element.id == e.idMember,
        );
        return UserDataAttendance(user, e);
      })).toList();
    }

    onChangedListUserDataAttendance(usersData);
    onChangedAttendaceList(usersData.map((e) => e.attendance).toList());
  }

  loadDates() {
    final listDateTime = targetPageFunctions.getDataDates(state);
    onChangedlistSaturdayDateMonth(listDateTime);
    DateTime? c1 = listDateTime.firstWhereOrNull((element) => DateController()
        .compareTwoDatesMajorDayExplicity(element, DateTime.now()));
    DateTime c = c1!;
    DateTime? c2 = listDateTime.firstWhereOrNull(
        (element) => DateController().compareTwoDates(element, DateTime.now()));
    c = c2 ?? c;

    onChangedDateTimeSelected(c);
  }

  onPressedBtnRegisterWhites(context) async {
    var keyForm = formKeyOfferingWhites.currentState;
    if (keyForm == null) return;
    var validate = keyForm.validate();
    if (!validate) return;
    FocusScope.of(context).unfocus();
    ProgressDialog.showV2(context, "Guardando");
    final response = await targetPageFunctions.sendRegisterOffering(state);

    String title = "Registro Exitoso";
    String content = "Blancos registrados";
    if (!response) {
      title = "No se registro";
      content = "Blancos no registrados";
    }
    await loadDataUnitOfferingSection(context);
    router.pop();
    await Dialogs.alert(context, title: title, content: content);

    router.pop();
  }

  onPressedBtnRegisterAttendances(context) async {
    ProgressDialog.show(context, double.infinity, double.infinity);
    List<UserDataAttendance>? list = state.listUserDataAttendance;
    String? idTarget = state.targetVirtualSelected!.id;
    final register =
        await targetPageFunctions.registerAttendanceDay(list!, idTarget!);

    String title = "Registro Exitoso";
    String content = "Asistencia registrados";
    if (!register) {
      title = "No se registro";
      content = "Asistencia no registrados";
    }

    router.pop();
    await Dialogs.alert(context, title: title, content: content);

    router.pop();
    await loadTableAttendance();
  }

  Future<void> onPressedNextDateTime(context) async {
    var list = state.listSaturdayDateMonth;
    var dateTime = state.dateTimeSelected;
    var index = list!.indexWhere(
        (element) => DateController().compareTwoDates(element, dateTime!));
    var indexNow = index + 1;
    if (indexNow < list.length) {
      onChangedDateTimeSelected(list[indexNow]);
      onChangedListUserDataAttendanceNull();
      await loadDataDialogShowAttendance(context);
    }
  }

  Future<void> onPressedLastDateTime(context) async {
    var list = state.listSaturdayDateMonth;
    var dateTime = state.dateTimeSelected;
    var index = list!.indexWhere(
        (element) => DateController().compareTwoDates(element, dateTime!));
    var indexNow = index - 1;
    if (indexNow >= 0) {
      onChangedDateTimeSelected(list[indexNow]);
      onChangedListUserDataAttendanceNull();
      await loadDataDialogShowAttendance(context);
    }
  }

  void onChangedUnitOfActionSelected(UnitOfAction unitOfAction) {
    state = state.copyWith(unitOfActionSelected: unitOfAction);
  }

  void onChangedListUnitOfAction(List<UnitOfAction> list) {
    state = state.copyWith(listUnitOfAction: list);
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

  void onChangedListUserDataAttendance(List<UserDataAttendance>? list) {
    log("message");
    state = state.copyWith(listUserDataAttendance: list);
  }

  void onChangedListUserDataAttendanceNull() {
    state = state.copyWithNull(listUserDataAttendance: null);
  }

  void onChangedlistSaturdayDateMonth(list) {
    state = state.copyWith(listSaturdayDateMonth: list);
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

  void onChangedOffering(DayOffering dayOffering) {
    state = state.copyWith(dayOffering: dayOffering);
  }

  void onChangedQuantity(double quantity) {
    state = state.copyWith(quantitiy: quantity);
  }

  void onChangedListDayOffering(List<DayOffering> list) {
    state = state.copyWith(listDayOffering: list);
  }

  void onChangedListQuarter(List<Quarter> listQuarter) {
    state = state.copyWith(listQuarter: listQuarter);
  }

  void onChangedOnWhite1(double white1) {
    state = state.copyWith(white1: white1);
  }

  void onChangedWhite2(double white2) {
    state = state.copyWith(white2: white2);
  }

  void onChangedListUserDataAttendances(listUserDataAttendances) {
    state = state.copyWith(listUserDataAttendances: listUserDataAttendances);
  }

  void changedStateUserDataAttendance(UserDataAttendance userDataAttendance) {
    List<Attendance> attendanceList = state.attendanceList;
    attendanceList
        .where((element) => element.idMember != userDataAttendance.user.id)
        .toList()
        .add(userDataAttendance.attendance);
    log("data changed");

    onChangedAttendaceList(attendanceList);
  }

  Future<void> onPressedBtnRegisterOffering(context) async {
    var keyForm = formKeyOffering.currentState;
    if (keyForm == null) return;
    var validate = keyForm.validate();
    if (!validate) return;
    FocusScope.of(context).unfocus();
    ProgressDialog.showV2(context, "Guardando");
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

    String title = "Registro Exitoso";
    String content = "Blancos registrados";
    if (!respose) {
      title = "No se registro";
      content = "Blancos no registrados";
    }

    var list = await _targetVirtual.getTargetVirtual(targetVirtual.id!);
    if (list == null) return;
    onChangedListDayOffering(list.offeringQuarter.map((e) => e).toList());
    router.pop();
    await Dialogs.alert(context, title: title, content: content);
    router.pop();
  }

  /* Widget willPopScope({bool isColorBackground = true}) {
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
  }*/

  //List<DataRow> listDataRow = [];

  /*List<DateTime> getMonthsInTheDates(DateTime start, DateTime end) {
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
  }*/

  /*List<Attendance> searchList(List<Attendance> s, String id) {
    var response = s.where((element) => element.idMember == id).toList();
    return response;
  }*/

  Future<void> itemsTable(TargetVirtual targetVirtual) async {
    var listMembers = await targetPageFunctions
        .getMembersUnitoOfAction(state.unitOfActionSelected!.id);

    var listDayAttendance =
        await _targetVirtual.getAttendanceIdTagetVirtual(targetVirtual.id!);
    final listDateSaturdays = state.listSaturdayDateMonth;
    listDateSaturdays!.sort((a, b) {
      return a.compareTo(b);
    });

    List<UserDataAttendances> listNEWW = listMembers
        .map(
          (e) => UserDataAttendances(e, []),
        )
        .toList();

    for (var date in listDateSaturdays) {
      DayAtendance? dayAttendance =
          listDayAttendance.firstWhereOrNull((element) => element.date == date);
      if (!(dayAttendance == null)) {
        for (var element in dayAttendance.attendance) {
          for (var member in listNEWW) {
            if (element.idMember == member.user.id) {
              member.attendance.add(element);
            }
          }
        }
      }

      onChangedListUserDataAttendances(listNEWW);
    }
  }

  DataRow item(UserDataAttendances s) {
    List<DataCell> list = [DataCell(Text(s.user.name))];
    //if (s.attendance.isNotEmpty) {
    list.addAll(s.attendance
        .map((e) => DataCell(Container(
            color: e!.state == "P" ? Colors.green.shade400 : null,
            child: Text(e.state.toString()))))
        .toList());
    //}

    return DataRow(selected: true, cells: list);
  }

  /*Future<List<DateTime>> getAttendanceAll() async {
    var listQuarter = await _eess.getEESSConfigQuarter();

    var dateTimeNow = DateTime.now();
    Quarter? quater = listQuarter.firstWhereOrNull((element) =>
        verificationDateQuarterv2(
            element.startTime, element.endTime, dateTimeNow));
    if (quater == null) return [];

    var r = getSaturdaysv2(quater.startTime, quater.endTime);
    return r;
  }*/

  @override
  void dispose() {
    super.dispose();
  }
}
