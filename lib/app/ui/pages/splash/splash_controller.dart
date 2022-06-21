import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/domain/repositories/authentication_repository.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

class SplashController extends SimpleNotifier {
  String? _routeName;
  String? get routeName => _routeName;
  final AuthenticationRepository _authRepository =
      Get.find<AuthenticationRepository>();

  SplashController() {
    _init();
    print(_authRepository.user);
  }

  void _init() async {
    final user = await _authRepository.user;
    _routeName = user != null ? Routes.HOME : Routes.LOGIN;
    print(_routeName);
    notify();
  }
}
