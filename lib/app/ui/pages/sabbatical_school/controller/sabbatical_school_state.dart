import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ja_app/app/domain/models/church/church.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/user_data.dart';

class SabbaticalSchoolState {
  final String? imageUser;
  final Church? church;
  final List<Tab> listTabr;
  final List<Widget> listTabBarView;
  final bool isSuscribeEESS;
  final bool isSuscribeChurch;
  final EESS? eess;
  final EESS? eessSelected;
  final bool isOk;
  final int isSuscribeEESSs;
  final UnitOfAction? unitOfAction;
  final List<UserData> membersUnitOfAction;
  final List<UnitOfAction> listUnitOfAction;

  final List<UserData> membersUnitOfActionNew;

  final String? titleSearch;

  final String? nameUnitOfActionCreate;
  final UserData? userDataUnitOfActionCreate;

  SabbaticalSchoolState({
    required this.church,
    required this.listUnitOfAction,
    required this.userDataUnitOfActionCreate,
    required this.nameUnitOfActionCreate,
    required this.membersUnitOfActionNew,
    required this.membersUnitOfAction,
    required this.unitOfAction,
    required this.isSuscribeEESSs,
    required this.isOk,
    required this.imageUser,
    required this.isSuscribeChurch,
    required this.eessSelected,
    required this.eess,
    required this.isSuscribeEESS,
    required this.listTabr,
    required this.listTabBarView,
    required this.titleSearch,
  });

  static SabbaticalSchoolState get initialState => SabbaticalSchoolState(
        church: null,
        listUnitOfAction: [],
        nameUnitOfActionCreate: null,
        userDataUnitOfActionCreate: null,
        membersUnitOfActionNew: [],
        membersUnitOfAction: [],
        unitOfAction: null,
        isSuscribeEESSs: 0,
        isOk: false,
        eessSelected: null,
        imageUser: null,
        listTabr: [],
        listTabBarView: [],
        isSuscribeEESS: false,
        isSuscribeChurch: false,
        eess: null,
        titleSearch: null,
      );

  SabbaticalSchoolState copyWith({
    Church? church,
    List<UnitOfAction>? listUnitOfAction,
    UnitOfAction? unitOfAction,
    int? isSuscribeEESSs,
    String? imageUser,
    List<Tab>? listTabr,
    List<Widget>? listTabBarView,
    bool? isSuscribeEESS,
    EESS? eess,
    EESS? eessSelected,
    bool? isSuscribeChurch,
    String? titleSearch,
    bool? isOk,
    List<UserData>? membersUnitOfAction,
    List<UserData>? membersUnitOfActionNew,
    String? nameUnitOfActionCreate,
    UserData? userDataUnitOfActionCreate,
  }) {
    return SabbaticalSchoolState(
      church: church ?? this.church,
      listUnitOfAction: listUnitOfAction ?? this.listUnitOfAction,
      nameUnitOfActionCreate:
          nameUnitOfActionCreate ?? this.nameUnitOfActionCreate,
      userDataUnitOfActionCreate:
          userDataUnitOfActionCreate ?? this.userDataUnitOfActionCreate,
      membersUnitOfActionNew:
          membersUnitOfActionNew ?? this.membersUnitOfActionNew,
      membersUnitOfAction: membersUnitOfAction ?? this.membersUnitOfAction,
      unitOfAction: unitOfAction ?? this.unitOfAction,
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
