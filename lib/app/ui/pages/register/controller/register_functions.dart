import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/userAvatar.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/progress_dialog.dart';
import 'package:ja_app/app/ui/pages/register/controller/register_state.dart';
import 'package:ja_app/app/ui/pages/register/utils/permisson_list.dart';
import 'package:ja_app/app/utils/email_service.dart';

import '../../../../data/repositories/login_repository/login_repository.dart';
import '../../../../data/repositories/register_repository/register_repository.dart';
import '../../../../data/repositories/resources_repository/resources_repository.dart';
import '../../../../domain/models/user_data.dart';
import '../../../../domain/responses/sign_up_response.dart';
import '../../../gobal_widgets/dialogs/dialogs.dart';
import '../../../routes/routes.dart';

class RegisterFunctions {
  final RegisterState state;
  final GlobalKey<FormState> formKeyOne = GlobalKey();
  final SessionController _sessionController;

  final GlobalKey<FormState> formKeyTwo = GlobalKey();

  late TabController tabController; // =  TabController(length: 3, vsync: this);

  final _signUpRepository = Get.find<RegisterRepository>();
  final _resources = Get.find<ResourcesRepository>();

  final _authRepository = Get.find<LoginRepository>();
  RegisterFunctions(this.state, this._sessionController);

  Future<List<UserAvatar>> getAvatars() async {
    List<UserAvatar> listAvatar = await _resources.getUservAvatarAll();
    return listAvatar;
  }

  Future<SignUpResponse> submit(state) async {
    final userData = UserData(
      name: state.name,
      lastName: state.lastName,
      lastNameSecond: state.lastNameSecond,
      nameSecond: state.nameSecond,
      phone: state.phone,
      userName: state.userName,
      email: state.email,
      password: state.password,
      photoURL: state.userAvatar!.url,
      birthDate: state.birthDate!,
      listPermisson: [PermissonList.C],
      bautizated: state.bautizatedCharacter.toString(),
      country: state.country!,
      gender: state.singingCharacter!.index.toString(),
    );
    final response = await _signUpRepository.register(userData);

    return response;
  }

  Future<void> sendRegisterForm(BuildContext context, states) async {
    FocusScope.of(context).unfocus();
    ProgressDialog.show(context, double.infinity, double.infinity);
    final response = await submit(states);
    if (response.error != null) {
      router.pop();
      late String content;
      switch (response.error) {
        case SignUpError.tooManyRequests:
          content = "Too many Requests";
          break;
        case SignUpError.emailAlreadyInUse:
          content = "Email already in use";
          break;
        case SignUpError.weakPassword:
          content = "weak password";
          break;
        case SignUpError.unknown:
          content = "error unknown";
          break;
        case SignUpError.networkRequestFailed:
          content = "network Request Failed";
          break;
        default:
          break;
      }
      Dialogs.alert(context, title: "ERROR", content: content);
    } else {
      await sendEmail(
          response.signUpData!.email,
          "¡Su registro fue exitoso!\n Los datos mas importantes para su inicio de sesión:\n\tEmail: " +
              response.signUpData!.email +
              "\n\tContraseña: " +
              response.signUpData!.password);

      if (_sessionController.userData != null) {
        final userNew = await _authRepository.userData;
        if (userNew != null) {
          final userMain = sessionProvider.read.userData;
          await sessionProvider.read.signOut();
          await _authRepository.signInWithEmailAndPassword(
              userMain!.email, userMain.password);
          final user = await _authRepository.userData;
          _sessionController.setUser(userMain);
        }
        router.pop();
        router.pop<UserData>(response.signUpData);
        // closePage(context);
      } else {
        router.pop();

        _sessionController.setUser(response.signUpData!);
        router.pushNamedAndRemoveUntil(Routes.HOME);
      }
    }
  }

  void closePage(BuildContext context) {
    Navigator.pop(context);
  }

  sendEmail(email, text) async {
    EmailService emailService = EmailService(
        email, "Registro de miembro " + DateTime.now().toString(), text);
    await emailService.sendEmail();
  }
}
