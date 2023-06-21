import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/side_menu/controller/side_menu_state.dart';

class SideMenuController extends StateNotifier<SideMenuState> {
  SessionController sessionController;
  String? _routeName;
  String? get routeName => _routeName;

  SideMenuController(this.sessionController)
      : super(SideMenuState.initialState) {}

  init() {}
}
