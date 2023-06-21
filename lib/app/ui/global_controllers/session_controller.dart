import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/domain/models/user_data.dart';

import '../../data/repositories/login_repository/login_repository.dart';

class SessionController extends SimpleNotifier {
  User? _user;
  UserData? _userData;
  User? get user => _user;
  UserData? get userData => _userData;

  final _auth = Get.find<LoginRepository>();

  void setUser(User user, UserData userData) {
    _user = user;
    _userData = userData;
    notify();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    _userData = null;
  }
}

final sessionProvider = SimpleProvider(
  (_) => SessionController(),
  autoDispose: false,
);
