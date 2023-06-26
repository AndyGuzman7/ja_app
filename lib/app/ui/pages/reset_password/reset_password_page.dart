import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/responses/reset_password_response.dart';

import 'package:ja_app/app/ui/gobal_widgets/dialogs/dialogs.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/progress_dialog.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_input_field.dart';
import 'package:ja_app/app/ui/pages/reset_password/controller/reset_password_controller.dart';
import 'package:ja_app/app/utils/email_validator.dart';
import 'package:ja_app/app/utils/name_validator.dart';

final resetPasswordProvider = SimpleProvider(
  (_) => ResetPasswordController(),
);

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return ProviderListener<ResetPasswordController>(
      provider: resetPasswordProvider,
      builder: (_, controller) => Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomInputField(
                    onChanged: controller.onEmailChanged,
                    label: 'Email',
                    inputType: TextInputType.emailAddress,
                  ),
                  ElevatedButton(
                    onPressed: () => _submit(context),
                    child: Text("Send"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _submit(BuildContext context) async {
    final controller = resetPasswordProvider.read;
    if (isValidEmail(controller.email)) {
      ProgressDialog.show(context, double.infinity, double.infinity);
      final response = await controller.submit();
      Navigator.pop(context);
      if (response == ResetPasswordResponse.ok) {
        Dialogs.alert(
          context,
          title: "GOOD",
          content: "Email sent",
        );
      } else {
        String errorMessage = "";
        switch (response) {
          case ResetPasswordResponse.networkRequestFailed:
            errorMessage = "network request failed";
            break;
          case ResetPasswordResponse.userDisabled:
            errorMessage = "user disabled";
            break;
          case ResetPasswordResponse.userNotFound:
            errorMessage = "user Not Fund";
            break;
          case ResetPasswordResponse.tooManyRequests:
            errorMessage = "too Many Request";
            break;
          case ResetPasswordResponse.unknown:
          default:
            errorMessage = "unknown error";
            break;
        }
        Dialogs.alert(
          context,
          title: "ERROR",
          content: errorMessage,
        );
      }
    } else {
      Dialogs.alert(context, content: "Invalid email");
    }
  }
}
