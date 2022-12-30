import 'package:firebase_auth/firebase_auth.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/domain/responses/sign_up_response.dart';

abstract class SignUpRepository {
  Future<SignUpResponse> register(UserData data, String codeRegister);
}
