import 'package:firebase_auth/firebase_auth.dart';
import 'package:ja_app/app/domain/inputs/sign_up.dart';
import 'package:ja_app/app/domain/responses/sign_up_response.dart';

abstract class SignUpRepository {
  Future<SignUpResponse> register(SignUpData data);
}
