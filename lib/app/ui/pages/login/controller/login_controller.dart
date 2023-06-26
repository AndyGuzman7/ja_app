import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/responses/sign_in_response.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/dialogs.dart';
import 'package:ja_app/app/ui/pages/login/login_page.dart';

import '../../../../data/repositories/login_repository/login_repository.dart';
import '../../../gobal_widgets/dialogs/progress_dialog.dart';
import '../../../routes/routes.dart';

class LoginController extends SimpleNotifier {
  final SessionController _sessionController;

  String _email = '';
  String _password = '';
  final _authenticationRepository = Get.find<LoginRepository>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginController(this._sessionController);

  void onEmailChanged(String text) {
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<SignInResponse> submit() async {
    final response = await _authenticationRepository.signInWithEmailAndPassword(
      _email,
      _password,
    );

    if (response.error == null) {
      _sessionController.setUser(response.userData!);
    }

    return response;
  }

  Future<void> sendLoginForm(BuildContext context) async {
    final controller = loginProvider.read;
    final isValidForm = controller.formKey.currentState!.validate();

    if (isValidForm) {
      ProgressDialog.show(context, double.infinity, double.infinity);
      final response = await controller.submit();
      router.pop();

      if (response.error != null) {
        String errorMessage = "";

        switch (response.error) {
          case SignInError.networkRequestFailed:
            errorMessage = "Network Request Failed";
            break;
          case SignInError.userDisabled:
            errorMessage = "User Disabled";
            break;
          case SignInError.userNotFound:
            errorMessage = "User Not Found";
            break;
          case SignInError.wrongPassword:
            errorMessage = "Wrong Password";
            break;
          case SignInError.tooManyRequests:
            errorMessage = "Too Many Requests";
            break;
          case SignInError.unknown:
          default:
            errorMessage = "Unknown Error";
            break;
        }

        Dialogs.alert(context, title: "ERROR", content: errorMessage);
      } else {
        Navigator.pushReplacementNamed(
          context,
          Routes.HOME,
        );
      }
    }
  }
}
