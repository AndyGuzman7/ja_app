import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/target_virtual/target_virtual.dart';
import 'package:ja_app/app/domain/models/user_data.dart';

import '../../../../../domain/models/eess/quarter.dart';

class TargetPageState {
  final UnitOfAction? unitOfActionSelected;
  final DateTime? dateTimeSelected;
  final TargetVirtual? targetVirtualSelected;
  final List<UnitOfAction> listUnitOfAction;

  final List<UserData> membersUnitOfActionSelected;
  final List<UserDataAttendance>? listUserDataAttendance;
  final List<DateTime>? listSaturdayDateMonth;
  final List<Quarter> listQuarter;
  final Quarter? quarter;
  final double? quantitiy;
  final double? white1, white2;

  final List<UserData> membersAttendance;
  final List<Attendance> attendanceList;
  final List<DayOffering> listDayOffering;
  final DayOffering? dayOffering;

  final List<UserDataAttendances>? listUserDataAttendances;

  TargetPageState({
    required this.listUserDataAttendances,
    required this.white1,
    required this.white2,
    required this.quantitiy,
    required this.listDayOffering,
    required this.dayOffering,
    required this.listQuarter,
    required this.quarter,
    required this.dateTimeSelected,
    required this.listSaturdayDateMonth,
    required this.listUserDataAttendance,
    required this.membersAttendance,
    required this.targetVirtualSelected,
    required this.attendanceList,
    required this.membersUnitOfActionSelected,
    required this.listUnitOfAction,
    required this.unitOfActionSelected,
  });

  static TargetPageState get initialState => TargetPageState(
        listUserDataAttendances: [],
        white1: 0.0,
        white2: 0.0,
        quantitiy: 0.0,
        dayOffering: null,
        listDayOffering: [],
        quarter: null,
        listQuarter: [],
        dateTimeSelected: null,
        listSaturdayDateMonth: [],
        listUserDataAttendance: null,
        targetVirtualSelected: null,
        attendanceList: [],
        membersAttendance: [],
        membersUnitOfActionSelected: [],
        listUnitOfAction: [],
        unitOfActionSelected: null,
      );

  TargetPageState copyWith(
      {List<Quarter>? listQuarter,
      List<UserDataAttendances>? listUserDataAttendances,
      Quarter? quarter,
      DateTime? dateTimeSelected,
      List<DateTime>? listSaturdayDateMonth,
      List<UserDataAttendance>? listUserDataAttendance,
      List<UserData>? membersAttendance,
      TargetVirtual? targetVirtualSelected,
      List<Attendance>? attendanceList,
      List<UnitOfAction>? listUnitOfAction,
      UnitOfAction? unitOfActionSelected,
      List<UserData>? membersUnitOfAction,
      List<UserData>? membersEESSNew,
      String? nameUnitOfActionCreate,
      UserData? userDataUnitOfActionCreate,
      List<DayOffering>? listDayOffering,
      DayOffering? dayOffering,
      double? white1,
      white2,
      double? quantitiy}) {
    log("stado");
    return TargetPageState(
      listUserDataAttendances:
          listUserDataAttendances ?? this.listUserDataAttendances,
      white1: white1 ?? this.white1,
      white2: white2 ?? this.white2,
      quantitiy: quantitiy ?? this.quantitiy,
      dayOffering: dayOffering ?? this.dayOffering,
      listDayOffering: listDayOffering ?? this.listDayOffering,
      quarter: quarter ?? this.quarter,
      listQuarter: listQuarter ?? this.listQuarter,
      dateTimeSelected: dateTimeSelected ?? this.dateTimeSelected,
      listSaturdayDateMonth:
          listSaturdayDateMonth ?? this.listSaturdayDateMonth,
      listUserDataAttendance:
          listUserDataAttendance ?? this.listUserDataAttendance,
      membersAttendance: membersAttendance ?? this.membersAttendance,
      targetVirtualSelected:
          targetVirtualSelected ?? this.targetVirtualSelected,
      attendanceList: attendanceList ?? this.attendanceList,
      membersUnitOfActionSelected:
          membersUnitOfAction ?? this.membersUnitOfActionSelected,
      unitOfActionSelected: unitOfActionSelected ?? this.unitOfActionSelected,
      listUnitOfAction: listUnitOfAction ?? this.listUnitOfAction,
    );
  }

  TargetPageState copyWithNull(
      {List<Quarter>? listQuarter,
      List<UserDataAttendances>? listUserDataAttendances,
      Quarter? quarter,
      DateTime? dateTimeSelected,
      List<DateTime>? listSaturdayDateMonth,
      List<UserDataAttendance>? listUserDataAttendance,
      List<UserData>? membersAttendance,
      TargetVirtual? targetVirtualSelected,
      List<Attendance>? attendanceList,
      List<UnitOfAction>? listUnitOfAction,
      UnitOfAction? unitOfActionSelected,
      List<UserData>? membersUnitOfAction,
      List<UserData>? membersEESSNew,
      String? nameUnitOfActionCreate,
      UserData? userDataUnitOfActionCreate,
      List<DayOffering>? listDayOffering,
      DayOffering? dayOffering,
      double? white1,
      white2,
      double? quantitiy}) {
    log("stado");
    return TargetPageState(
      listUserDataAttendances:
          listUserDataAttendances ?? this.listUserDataAttendances,
      white1: white1 ?? this.white1,
      white2: white2 ?? this.white2,
      quantitiy: quantitiy ?? this.quantitiy,
      dayOffering: dayOffering ?? this.dayOffering,
      listDayOffering: listDayOffering ?? this.listDayOffering,
      quarter: quarter ?? this.quarter,
      listQuarter: listQuarter ?? this.listQuarter,
      dateTimeSelected: dateTimeSelected ?? this.dateTimeSelected,
      listSaturdayDateMonth:
          listSaturdayDateMonth ?? this.listSaturdayDateMonth,
      listUserDataAttendance: listUserDataAttendance,
      membersAttendance: membersAttendance ?? this.membersAttendance,
      targetVirtualSelected:
          targetVirtualSelected ?? this.targetVirtualSelected,
      attendanceList: attendanceList ?? this.attendanceList,
      membersUnitOfActionSelected:
          membersUnitOfAction ?? this.membersUnitOfActionSelected,
      unitOfActionSelected: unitOfActionSelected ?? this.unitOfActionSelected,
      listUnitOfAction: listUnitOfAction ?? this.listUnitOfAction,
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
