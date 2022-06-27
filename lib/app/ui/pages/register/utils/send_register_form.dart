import 'package:flutter/cupertino.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/inputs/sign_up.dart';
import 'package:ja_app/app/domain/responses/sign_up_response.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/dialogs.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/progress_dialog.dart';
import 'package:ja_app/app/ui/pages/register/register_page.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

Future<void> sendRegisterForm(BuildContext context) async {
  final controller = registerProvider.read;
  final isValidForm = controller.formKey.currentState!.validate();

  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
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
      router.pushNamedAndRemoveUntil(Routes.HOME);
    }
  } else {
    Dialogs.alert(context, title: "ERROR", content: "Invalid fields");
  }
}
