import 'package:firebase_auth/firebase_auth.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';

class SignUpData {
  String id, name, lastName, email, password, photoURL, birthDate;
  List<String> listPermisson;
  /*
    - usuario normal
    - usuario administrador
    - usuario pastor de iglesia
    - usuario director de ministerio
       - usuario lider asociado ministerio
    - usuario maestro de escuala sabatica
  */
  SignUpData({
    this.id = '',
    required this.listPermisson,
    required this.photoURL,
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    required this.birthDate,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) {
    return SignUpData(
      listPermisson: List<String>.from(json['listPermisson']),
      id: json['id'],
      photoURL: json['photoURL'],
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      birthDate: json['birthDate'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'listPermisson': listPermisson,
        'photoURL': photoURL,
        'name': name,
        'lastName': lastName,
        'email': email,
        'password': password,
        'birthDate': birthDate
      };
}
