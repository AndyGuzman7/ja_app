import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/domain/inputs/sign_up.dart';
import 'package:ja_app/app/domain/repositories/authentication_repository.dart';
import 'package:ja_app/app/domain/repositories/sign_up_repository.dart';
import 'package:ja_app/app/domain/responses/sign_up_response.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/pages/register/controller/register_state.dart';

class RegisterController extends StateNotifier<RegisterState> {
  final SessionController _sessionController;
  RegisterController(this._sessionController)
      : super(RegisterState.initialState);
  final GlobalKey<FormState> formKey = GlobalKey();

  final _signUpRepository = Get.find<SignUpRepository>();

  Future<SignUpResponse> submit() async {
    final response = await _signUpRepository.register(SignUpData(
      name: state.name,
      lastName: state.lastName,
      email: state.email,
      password: state.password,
    ));

    if (response.error == null) {
      _sessionController.setUser(response.user!);
    }
    return response;
  }

  void onNameChanged(String text) {
    state = state.copyWith(name: text);
  }

  void onlastNameChanged(String text) {
    state = state.copyWith(lastName: text);
  }

  void onEmailChanged(String text) {
    state = state.copyWith(email: text);
  }

  void onPasswordChanged(String text) {
    state = state.copyWith(password: text);
  }

  void onVPasswordChanged(String text) {
    state = state.copyWith(vPassword: text);
  }
}
