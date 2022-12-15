import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/data/repositories/user_impl/login_impl/authentication_repository.dart';
import 'package:ja_app/app/data/repositories/user_impl/user_repository.dart';
import 'package:ja_app/app/domain/models/sign_up.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';

class HomeController extends SimpleNotifier {
  final userRepository = Get.find<UserRepository>();
  final SessionController sessionController;

  HomeController(this.sessionController) {}

  Future<SignUpData?> getUser() async {
    SignUpData? data;
    try {
      log(sessionController.user!.toString());
      data = await userRepository.getUser(sessionController.user!.uid);

      return data!;
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
