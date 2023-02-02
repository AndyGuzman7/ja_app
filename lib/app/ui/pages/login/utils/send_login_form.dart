import 'package:flutter/cupertino.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/responses/sign_in_response.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/dialogs.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/progress_dialog.dart';
import 'package:ja_app/app/ui/pages/login/login_page.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

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
          errorMessage = "network Request Failed";
          break;
        case SignInError.userDisabled:
          errorMessage = "user Disable";
          break;
        case SignInError.userNotFound:
          errorMessage = "user not Found";
          break;
        case SignInError.wrongPassword:
          errorMessage = "wrong password";
          break;
        case SignInError.tooManyRequests:
          errorMessage = "too many request";
          break;
        case SignInError.unknown:
        default:
          errorMessage = "error unknown";

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
