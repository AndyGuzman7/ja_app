import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

import '../../../data/repositories/login_repository/login_repository.dart';
import '../../../data/repositories/user_repository/user_repository.dart';

class SplashController extends SimpleNotifier {
  final SessionController _sessionController;
  String? _routeName;
  String? get routeName => _routeName;
  final _authRepository = Get.find<LoginRepository>();
  final _userRepository = Get.find<UserRepository>();

  SplashController(this._sessionController) {
    init();
  }

  void init() async {
    final user = await _authRepository.user;

    if (user != null) {
      final userData = await _userRepository.getUser(user.uid);
      _routeName = Routes.HOME;
      _sessionController.setUser(user, userData!);
    } else {
      _routeName = Routes.LOGIN;
    }

    notify();
  }
}
