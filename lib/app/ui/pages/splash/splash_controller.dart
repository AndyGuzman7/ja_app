import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/data/repositories/user_impl/login_impl/authentication_repository.dart';
import 'package:ja_app/app/data/repositories/user_impl/user_repository.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

class SplashController extends SimpleNotifier {
  final SessionController _sessionController;
  String? _routeName;
  String? get routeName => _routeName;
  final _authRepository = Get.find<AuthenticationRepository>();
  final _userRepository = Get.find<UserRepository>();

  SplashController(this._sessionController) {
    _init();
  }

  void _init() async {
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
