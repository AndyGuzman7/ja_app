import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ja_app/app/domain/models/country.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/drop_dow/custom_dropDownButton%20copy.dart';

import '../../../../domain/models/userAvatar.dart';

class HomeState {
  final UserData? user;
  final int currentTab;
  final String title;

  HomeState({
    required this.title,
    required this.currentTab,
    required this.user,
  });

  static HomeState get initialState => HomeState(
        title: 'Inicio',
        currentTab: 0,
        user: null,
      );

  HomeState copyWith({
    UserData? user,
    int? currentTab,
    String? title,
  }) {
    return HomeState(
        currentTab: currentTab ?? this.currentTab,
        user: user ?? this.user,
        title: title ?? this.title);
  }
}
