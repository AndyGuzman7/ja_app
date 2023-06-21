import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/domain/responses/sign_in_response.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';

import '../../../../data/repositories/login_repository/login_repository.dart';

class LoginController extends SimpleNotifier {
  final SessionController _sessonController;

  String _email = '', _password = '';
  final _authenticationRepository = Get.find<LoginRepository>();

  final GlobalKey<FormState> formKey = GlobalKey();

  LoginController(this._sessonController);
  void onEmailChanged(String text) {
    log("el cambio dice + " + text);
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<SignInResponse> submit() async {
    final response = await _authenticationRepository.singInWithEmailAndPassword(
      _email,
      _password,
    );

    if (response.error == null) {
      _sessonController.setUser(response.user!, response.userData!);
      log(response.user!.displayName!);
    }
    return response;
  }
}
