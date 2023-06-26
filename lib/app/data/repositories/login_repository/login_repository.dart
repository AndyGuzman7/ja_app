import 'package:firebase_auth/firebase_auth.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/domain/responses/reset_password_response.dart';
import 'package:ja_app/app/domain/responses/sign_in_response.dart';
import 'package:ja_app/app/ui/pages/reset_password/reset_password_page.dart';

abstract class LoginRepository {
  Future<UserData?> get userData;
  Future<void> signOut();
  Future<SignInResponse> signInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<ResetPasswordResponse?> sendResetPasswordLink(String email);
}
