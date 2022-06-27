import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:ja_app/app/domain/responses/reset_password_response.dart';
import 'package:ja_app/app/domain/responses/sign_in_response.dart';
import 'package:ja_app/app/ui/pages/reset_password/controller/reset_password_controller.dart';

import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  late final FirebaseAuth _auth;
  User? _user;
  final Completer<void> _completer = Completer();

  AuthenticationRepositoryImpl(FirebaseAuth auth) {
    _auth = auth;
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed outsss!');
      } else {
        print('User is signed in!');
      }
    });
    print("fuego");
    _init();
  }
  @override
  Future<User?> get user async {
    await _completer.future;

    return _user;
  }

  void _init() async {
    _auth.authStateChanges().listen((User? user) {
      if (!_completer.isCompleted) {
        _completer.complete();
      }
      _user = user;
    });
  }

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }

  @override
  Future<SignInResponse> singInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user!;
      return SignInResponse(null, user);
    } on FirebaseAuthException catch (e) {
      return SignInResponse(stringToSignInError(e.code), null);
    }
  }

  @override
  Future<ResetPasswordResponse?> sendResetPasswordLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      //print("!-----------------------asasdasdasd");
      return ResetPasswordResponse.ok;
    } on FirebaseException catch (e) {
      print(e.code);
      return stringToResetPasswordResponse(e.code);
    }
  }
}
