import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/domain/models/sign_up.dart';
import 'package:ja_app/app/domain/models/resources.dart';
import 'package:ja_app/app/data/repositories/user_impl/login_impl/authentication_repository.dart';
import 'package:ja_app/app/data/repositories/resources_impl/resources_repository.dart';
import 'package:ja_app/app/data/repositories/user_impl/register_impl/sign_up_repository.dart';
import 'package:ja_app/app/domain/responses/sign_up_response.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/pages/register/controller/register_state.dart';
import 'package:ja_app/app/ui/pages/register/utils/permisson_list.dart';

class RegisterController extends StateNotifier<RegisterState> {
  final SessionController _sessionController;
  RegisterController(this._sessionController)
      : super(RegisterState.initialState);
  final GlobalKey<FormState> formKey = GlobalKey();

  final _signUpRepository = Get.find<SignUpRepository>();

  final _resourcesRepository = Get.find<ResourcesRepository>();

  Future<SignUpResponse> submit() async {
    if (state.photo != null) {
      await uploadPfp(state.photo!);
    } else {
      Resources listResources = await _resourcesRepository.getImagesLink();
      onImageURLChanged(listResources.images[0]);
    }

    final response = await _signUpRepository.register(
      SignUpData(
        name: state.name,
        lastName: state.lastName,
        email: state.email,
        password: state.password,
        photoURL: state.photoURL,
        birthDate: state.birthDate,
        listPermisson: [PermissonList.C],
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

  void onBirthDateChanged(DateTime text) {
    state = state.copyWith(birthDate: text.toIso8601String());
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
