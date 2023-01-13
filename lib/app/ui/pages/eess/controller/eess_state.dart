import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';

class EeSsState {
  final String? imageUser;
  final List<Tab> listTabr;
  final List<Widget> listTabBarView;
  final bool isSuscribeEESS;
  final bool isSuscribeChurch;
  final EESS? eess;
  final EESS? eessSelected;
  final bool isOk;
  final int isSuscribeEESSs;
  final UnitOfAction? unitOfAction;

  final String? titleSearch;

  EeSsState({
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

  static EeSsState get initialState => EeSsState(
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

  EeSsState copyWith({
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
  }) {
    log("stado");
    return EeSsState(
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
