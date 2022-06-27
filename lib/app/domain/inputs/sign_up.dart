import 'package:firebase_auth/firebase_auth.dart';

class SignUpData {
  final String name, lastName, email, password;

  SignUpData(
      {required this.name,
      required this.lastName,
      required this.email,
      required this.password});
}
