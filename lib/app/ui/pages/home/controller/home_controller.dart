import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/data/repositories/user_impl/login_impl/authentication_repository.dart';
import 'package:ja_app/app/data/repositories/user_impl/user_repository.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';

class HomeController extends SimpleNotifier {
  final userRepository = Get.find<UserRepository>();
  final SessionController sessionController;

  HomeController(this.sessionController) {}

  Future<UserData?> getUser() async {
    UserData? data;
    //try {
    log(sessionController.user!.uid.toString());
    data = await userRepository.getUser(sessionController.user!.uid);
    log("adadaddasdasd");
    log(data.toString());
    return data!;
    //} catch (e) {
    //  return null;
    //}
  }

  @override
  void dispose() {
    super.dispose();
  }
}
