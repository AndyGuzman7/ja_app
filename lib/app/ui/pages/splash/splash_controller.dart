import 'dart:developer';

import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

import '../../../data/repositories/login_repository/login_repository.dart';
import '../../../data/repositories/user_repository/user_repository.dart';

class SplashController extends SimpleNotifier {
  final LoginRepository _loginRepository = Get.find<LoginRepository>();
  final SessionController _sessionController;

  String? _routeName;
  String? get routeName => _routeName;

  SplashController(this._sessionController) {
    init();
  }

  void init() async {
    final user = await _loginRepository.userData;

    if (user == null) {
      _routeName = Routes.LOGIN;
    } else {
      _routeName = Routes.HOME;
      _sessionController.setUser(user);
    }

    notify();
  }
}
