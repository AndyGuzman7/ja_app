import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/user_data.dart';

class UnitPageState {
  final UnitOfAction? unitOfAction;
  final List<UnitOfAction> listUnitOfAction;
  final String? nameUnitOfActionCreate;
  final UserData? userDataUnitOfActionCreate;
  final List<UserData> membersUnitOfActionNew;
  final List<UserData> membersUnitOfAction;

  UnitPageState({
    required this.membersUnitOfAction,
    required this.membersUnitOfActionNew,
    required this.listUnitOfAction,
    required this.userDataUnitOfActionCreate,
    required this.nameUnitOfActionCreate,
    required this.unitOfAction,
  });

  static UnitPageState get initialState => UnitPageState(
        membersUnitOfAction: [],
        membersUnitOfActionNew: [],
        listUnitOfAction: [],
        nameUnitOfActionCreate: null,
        userDataUnitOfActionCreate: null,
        unitOfAction: null,
      );

  UnitPageState copyWith({
    List<UnitOfAction>? listUnitOfAction,
    UnitOfAction? unitOfAction,
    List<UserData>? membersUnitOfAction,
    List<UserData>? membersUnitOfActionNew,
    String? nameUnitOfActionCreate,
    UserData? userDataUnitOfActionCreate,
  }) {
    log("stado");
    return UnitPageState(
      membersUnitOfAction: membersUnitOfAction ?? this.membersUnitOfAction,
      membersUnitOfActionNew:
          membersUnitOfActionNew ?? this.membersUnitOfActionNew,
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
