import 'package:firebase_auth/firebase_auth.dart';

class SignUpData {
  final String name, lastName, email, password, photoURL, birthDate;

  SignUpData({
    required this.photoURL,
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    required this.birthDate,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) {
    return SignUpData(
      photoURL: json['photoURL'],
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      birthDate: json['birthDate'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'photoURL': photoURL,
        'name': name,
        'lastName': lastName,
        'email': email,
        'password': password,
        'birthDate': birthDate
      };
}
