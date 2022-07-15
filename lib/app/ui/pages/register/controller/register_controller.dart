import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
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
    await uploadPfp(state.photo!);
    final response = await _signUpRepository.register(
      SignUpData(
        name: state.name,
        lastName: state.lastName,
        email: state.email,
        password: state.password,
        photoURL: state.photoURL,
        birthDate: state.birthDate,
      ),
    );

    if (response.error == null) {
      _sessionController.setUser(response.user!);
    }
    return response;
  }

  Future<void> uploadPfp(File file) async {
    File uploadFile = file;
    String path;

    await FirebaseStorage.instance
        .ref('uploads/${uploadFile.path}')
        .putFile(uploadFile)
        .then((p0) async {
      await p0.ref.getDownloadURL().then((value) {
        onImageURLChanged(value);
      });
    });
  }

  void onNameChanged(String text) {
    state = state.copyWith(name: text);
  }

  void onPhotoChanged(File file) {
    state = state.copyWith(photo: file);
  }

  void onBirthDateChanged(String text) {
    state = state.copyWith(birthDate: text);
  }

  void onImageURLChanged(String text) {
    state = state.copyWith(photoURL: text);
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
