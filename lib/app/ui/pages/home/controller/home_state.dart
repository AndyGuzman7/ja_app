import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ja_app/app/domain/models/country.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/drop_dow/custom_dropDownButton%20copy.dart';

import '../../../../domain/models/userAvatar.dart';

class HomeState {
  final UserData? user;
  final String email;
  final String password;
  final String vPassword;
  final String userName;
  final String name;
  final String nameSecond;
  final String lastName;
  final String lastNameSecond;
  final DateTime? birthDate;
  final String photoURL;
  final String phone;
  final File? photo;
  final UserAvatar? userAvatar;
  final List<UserAvatar>? listAvatar;
  final bool? termsOk;
  final SingingCharacter? singingCharacter;
  final BautizatedCharacter? bautizatedCharacter;
  final Country? country;
  final String? codeRegister;

  HomeState({
    required this.user,
    required this.email,
    required this.password,
    required this.vPassword,
    required this.name,
    required this.lastName,
    required this.birthDate,
    required this.photoURL,
    required this.photo,
    required this.userAvatar,
    required this.listAvatar,
    required this.termsOk,
    required this.singingCharacter,
    required this.country,
    required this.bautizatedCharacter,
    required this.nameSecond,
    required this.lastNameSecond,
    required this.phone,
    required this.userName,
    required this.codeRegister,
  });

  static HomeState get initialState => HomeState(
        user: null,
        email: '',
        password: '',
        vPassword: '',
        name: '',
        lastName: '',
        birthDate: null,
        photoURL: '',
        photo: null,
        userAvatar: null,
        listAvatar: [],
        termsOk: false,
        singingCharacter: SingingCharacter.male,
        bautizatedCharacter: BautizatedCharacter.no,
        country: null,
        phone: '',
        nameSecond: '',
        lastNameSecond: '',
        userName: '',
        codeRegister: null,
      );

  HomeState copyWith({
    UserData? user,
    String? email,
    String? password,
    String? vPassword,
    String? name,
    String? lastName,
    DateTime? birthDate,
    String? photoURL,
    File? photo,
    UserAvatar? userAvatar,
    List<UserAvatar>? listAvatar,
    bool? termsOk,
    SingingCharacter? singingCharacter,
    BautizatedCharacter? bautizatedCharacter,
    Country? country,
    String? nameSecond,
    String? lastNameSecond,
    String? phone,
    String? userName,
    String? codeRegister,
  }) {
    return HomeState(
        user: user ?? this.user,
        email: email ?? this.email,
        password: password ?? this.password,
        vPassword: vPassword ?? this.vPassword,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        birthDate: birthDate ?? this.birthDate,
        photoURL: photoURL ?? this.photoURL,
        termsOk: termsOk ?? this.termsOk,
        listAvatar: listAvatar ?? this.listAvatar,
        photo: photo ?? this.photo,
        userAvatar: userAvatar ?? this.userAvatar,
        singingCharacter: singingCharacter ?? this.singingCharacter,
        bautizatedCharacter: bautizatedCharacter ?? this.bautizatedCharacter,
        country: country ?? this.country,
        userName: userName ?? this.userName,
        nameSecond: nameSecond ?? this.nameSecond,
        lastNameSecond: lastNameSecond ?? this.lastNameSecond,
        phone: phone ?? this.phone,
        codeRegister: codeRegister ?? this.codeRegister);
  }
}
