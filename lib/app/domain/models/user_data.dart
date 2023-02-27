import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ja_app/app/domain/models/country.dart';

class UserData {
  String id, name, userName, lastName, email, password, photoURL;
  String gender;
  Country country;
  String phone;
  String bautizated;
  String? nameSecond, lastNameSecond;
  DateTime birthDate;
  List<String> listPermisson;
  /*
    - usuario normal
    - usuario administrador
    - usuario pastor de iglesia
    - usuario director de ministerio
       - usuario lider asociado ministerio
    - usuario maestro de escuala sabatica
  */
  UserData({
    this.id = '',
    required this.userName,
    required this.name,
    this.nameSecond,
    required this.lastName,
    this.lastNameSecond,
    required this.gender,
    required this.birthDate,
    required this.country,
    required this.phone,
    required this.bautizated,
    required this.email,
    required this.password,
    required this.listPermisson,
    required this.photoURL,
  });

  get fullName => name + " " + lastName + " " + lastNameSecond!;

  factory UserData.fromJson(Map<String, dynamic> json) {
    DateTime toDate(timestamp) {
      Timestamp s = timestamp;
      return s.toDate();
    }

    return UserData(
        listPermisson: List<String>.from(json['listPermisson']),
        id: json['id'],
        userName: json['userName'],
        photoURL: json['photoURL'],
        name: json['name'],
        lastName: json['lastName'],
        email: json['email'],
        password: json['password'],
        birthDate: toDate(json['birthDate']),
        nameSecond: json['nameSecond'],
        lastNameSecond: json['lastNameSecond'],
        gender: json['gender'],
        country: Country.fromJson(json['country']),
        phone: json['phone'],
        bautizated: json['bautizated']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userName': userName,
        'listPermisson': listPermisson,
        'photoURL': photoURL,
        'name': name,
        'lastName': lastName,
        'email': email,
        'password': password,
        'birthDate': birthDate,
        'nameSecond': nameSecond,
        'lastNameSecond': lastNameSecond,
        'gender': gender,
        'country': country.toJson(),
        'bautizated': bautizated,
        'phone': phone,
      };
}
