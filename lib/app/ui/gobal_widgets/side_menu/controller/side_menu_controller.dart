import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/data/repositories_impl/user/user_repository_impl.dart';
import 'package:ja_app/app/data/repositories/user_impl/login_impl/authentication_repository.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/side_menu/controller/side_menu_state.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

class SideMenuController extends StateNotifier<SideMenuState> {
  SessionController _sessionController;
  String? _routeName;
  String? get routeName => _routeName;
  final _authRepository = Get.find<AuthenticationRepository>();
  final _userRepository = Get.find<UserRepositoryImpl>();

  SideMenuController(this._sessionController)
      : super(SideMenuState.initialState) {}

  init() {}
}
