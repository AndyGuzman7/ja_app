import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  late final FirebaseAuth _auth;
  User? _user;
  final Completer<void> _completer = Completer();

  AuthenticationRepositoryImpl(this._auth) {
    print("sadasd");
    _init();
  }
  @override
  Future<User?> get user async {
    await _completer.future;
    return _user;
  }

  void _init() async {
    _auth.authStateChanges().listen((User? user) {
      if (_completer.isCompleted) {
        _completer.complete();
      }
      _user = user;
    });
  }
}
