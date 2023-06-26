import 'dart:developer';
import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';

import '../../../../data/repositories/user_repository/user_repository.dart';
import 'home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  final userRepository = Get.find<UserRepository>();
  final SessionController sessionController;

  HomeController(this.sessionController) : super(HomeState.initialState) {
    init();
  }

  init() {
    UserData? data = sessionController.userData;
    onChangedUser(data!);
  }

  void onChangedUser(UserData user) {
    state = state.copyWith(userData: user);
  }

  void onChangedCurrentTab(int currentTab) {
    state = state.copyWith(currentTab: currentTab);
  }

  void onChangedTitle(String title) {
    state = state.copyWith(title: title);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
