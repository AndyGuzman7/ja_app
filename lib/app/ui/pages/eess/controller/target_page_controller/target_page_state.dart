import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/target_virtual/target_virtual.dart';
import 'package:ja_app/app/domain/models/user_data.dart';

class TargetPageState {
  final UnitOfAction? unitOfAction;
  final DateTime? dateTimeSelected;
  final TargetVirtual? targetVirtualSelected;
  final List<UnitOfAction> listUnitOfAction;
  final String? nameUnitOfActionCreate;
  final UserData? userDataUnitOfActionCreate;
  final List<UserData> membersEESSNew;
  final List<UserData> membersUnitOfAction;
  final List<UserDataAttendance> listUserDataAttendance;
  final List<DateTime>? listDateTimeMonth;

  final List<UserData> membersAttendance;
  final List<Attendance> attendanceList;

  TargetPageState({
    required this.dateTimeSelected,
    required this.listDateTimeMonth,
    required this.listUserDataAttendance,
    required this.membersAttendance,
    required this.targetVirtualSelected,
    required this.attendanceList,
    required this.membersUnitOfAction,
    required this.membersEESSNew,
    required this.listUnitOfAction,
    required this.userDataUnitOfActionCreate,
    required this.nameUnitOfActionCreate,
    required this.unitOfAction,
  });

  static TargetPageState get initialState => TargetPageState(
        dateTimeSelected: null,
        listDateTimeMonth: [],
        listUserDataAttendance: [],
        targetVirtualSelected: null,
        attendanceList: [],
        membersAttendance: [],
        membersUnitOfAction: [],
        membersEESSNew: [],
        listUnitOfAction: [],
        nameUnitOfActionCreate: null,
        userDataUnitOfActionCreate: null,
        unitOfAction: null,
      );

  TargetPageState copyWith({
    DateTime? dateTimeSelected,
    List<DateTime>? listDateTimeMonth,
    List<UserDataAttendance>? listUserDataAttendance,
    List<UserData>? membersAttendance,
    TargetVirtual? targetVirtualSelected,
    List<Attendance>? attendanceList,
    List<UnitOfAction>? listUnitOfAction,
    UnitOfAction? unitOfAction,
    List<UserData>? membersUnitOfAction,
    List<UserData>? membersEESSNew,
    String? nameUnitOfActionCreate,
    UserData? userDataUnitOfActionCreate,
  }) {
    log("stado");
    return TargetPageState(
      dateTimeSelected: dateTimeSelected ?? this.dateTimeSelected,
      listDateTimeMonth: listDateTimeMonth ?? this.listDateTimeMonth,
      listUserDataAttendance:
          listUserDataAttendance ?? this.listUserDataAttendance,
      membersAttendance: membersAttendance ?? this.membersAttendance,
      targetVirtualSelected:
          targetVirtualSelected ?? this.targetVirtualSelected,
      attendanceList: attendanceList ?? this.attendanceList,
      membersUnitOfAction: membersUnitOfAction ?? this.membersUnitOfAction,
      membersEESSNew: membersEESSNew ?? this.membersEESSNew,
      unitOfAction: unitOfAction ?? this.unitOfAction,
      listUnitOfAction: listUnitOfAction ?? this.listUnitOfAction,
      nameUnitOfActionCreate:
          nameUnitOfActionCreate ?? this.nameUnitOfActionCreate,
      userDataUnitOfActionCreate:
          userDataUnitOfActionCreate ?? this.userDataUnitOfActionCreate,
    );
  }

  /*EeSsState copyWithBoolean({
    bool? isSuscribeEESS,
    bool? isSuscribeChurch,
    bool? isOk,
  }) {
    log("stado");
    return EeSsState(
      isSuscribeEESSs: isSuscribeEESSs ?? this.isSuscribeEESSs,
      isOk: isOk ?? this.isOk,
      titleSearch: titleSearch ?? this.titleSearch,
      eess: eess ?? this.eess,
      eessSelected: eessSelected ?? this.eessSelected,
      isSuscribeChurch: isSuscribeChurch ?? this.isSuscribeChurch,
      isSuscribeEESS: isSuscribeEESS ?? this.isSuscribeEESS,
      listTabBarView: listTabBarView ?? this.listTabBarView,
      listTabr: listTabr ?? this.listTabr,
      imageUser: imageUser ?? this.imageUser,
    );
  }*/
}
