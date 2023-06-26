import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ja_app/app/data/repositories_impl/user_repository_impl/user_repository_impl.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/domain/responses/reset_password_response.dart';
import 'package:ja_app/app/domain/responses/sign_in_response.dart';

import '../../../repositories/login_repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  late final FirebaseAuth _auth;
  late final FirebaseFirestore _firestore;
  late final UserRepositoryImpl _userRepository;
  UserData? _userData;
  final Completer<void> _completer = Completer();

  LoginRepositoryImpl(FirebaseAuth auth, FirebaseFirestore firestore) {
    _auth = auth;
    _firestore = firestore;
    _userRepository = UserRepositoryImpl(_firestore);

    _init();
  }
  @override
  Future<UserData?> get userData async {
    await _completer.future;
    return _userData;
  }

  void _init() async {
    _auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        _userData = await _userRepository.getUser(user.uid);
        if (_userData != null) {
          _userData!.userFirebase = user;
        }
      }
      if (!_completer.isCompleted) {
        _completer.complete();
      }
    });
  }

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }

  @override
  Future<SignInResponse> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user!;
      final userData = await _userRepository.getUser(user.uid);
      userData!.userFirebase = user;

      return SignInResponse(null, userData);
    } on FirebaseAuthException catch (e) {
      return SignInResponse(stringToSignInError(e.code), null);
    }
  }

  @override
  Future<ResetPasswordResponse?> sendResetPasswordLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      return ResetPasswordResponse.ok;
    } on FirebaseException catch (e) {
      print(e.code);
      return stringToResetPasswordResponse(e.code);
    }
  }
}
