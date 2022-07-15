import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/domain/repositories/authentication_repository.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

class SideMenuController extends SimpleNotifier {
  SessionController _sessionController;
  String? _routeName;
  String? get routeName => _routeName;
  final _authRepository = Get.find<AuthenticationRepository>();

  SideMenuController(this._sessionController) {
    _init();
  }

  void _init() async {
    final user = await _authRepository.user;
    if (user != null) {
      _routeName = Routes.HOME;
      _sessionController.setUser(user);
    } else {
      _routeName = Routes.LOGIN;
    }

    notify();
  }
}
