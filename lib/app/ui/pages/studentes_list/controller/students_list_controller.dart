import 'dart:developer';

import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/data/repositories/user_impl/user_repository.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';

class StudentsListController extends SimpleNotifier {
  final userRepository = Get.find<UserRepository>();
  final SessionController sessionController;
  StudentsListController(this.sessionController);
  Future<List<UserData?>> getUsers() async {
    List<UserData?> data;
    try {
      log(sessionController.user!.toString());
      data = await userRepository.getUsers();

      return data;
    } catch (e) {
      return [null];
    }
  }
}