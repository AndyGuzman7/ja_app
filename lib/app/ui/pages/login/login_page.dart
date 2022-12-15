import 'package:flutter/material.dart';

import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/background/backgroundImage.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_button.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_input_field.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_textButton.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/pages/login/controller/login_controller.dart';
import 'package:ja_app/app/ui/pages/login/utils/send_login_form.dart';
import 'package:ja_app/app/ui/routes/routes.dart';
import 'package:ja_app/app/utils/email_validator.dart';

final loginProvider = SimpleProvider(
  (_) => LoginController(sessionProvider.read),
);

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _controller = loginProvider.read;
  @override
  Widget build(BuildContext context) {
    final Image image = Image.asset('assets/images/1743165.jpg');

    return ProviderListener<LoginController>(
      provider: loginProvider,
      builder: (_, controller) {
        double height = MediaQuery.of(_).size.height;

        return BackGroundIamge(
          image: image,
          child: SingleChildScrollView(
            child: SizedBox(
              height: height,
              child: SafeArea(
                  child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const CustomTitle2(
                          isBoldTitle: true,
                          title: 'Hey! Welcome back',
                          subTitle: 'Sign in to your acount',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomImputField(
                          label: "email",
                          icon: const Icon(Icons.email),
                          onChanged: controller.onEmailChanged,
                          inputType: TextInputType.emailAddress,
                          validator: (text) {
                            if (isValidEmail(text!)) {
                              return null;
                            }

                            return "Invalid email";
                          },
                        ),
                        /*CustomImputDatePicker(
                              label: 'Date birth day',
                              validator: (text) {
                                print(text);
                                if (text == null) return "invalid last name";
                              },
                            ),*/
                        const SizedBox(
                          height: 20,
                        ),
                        CustomImputField(
                          icon: Icon(Icons.security_outlined),
                          label: "Password",
                          onChanged: controller.onPasswordChanged,
                          isPassword: true,
                          validator: (text) {
                            if (text!.trim().length >= 6) {
                              return null;
                            }

                            return "Invalid password";
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () =>
                                  router.pushNamed(Routes.RESET_PASSWORD),
                              child: const Text("Forgot Password?"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          textButton: 'Sign in',
                          onPressed: () => sendLoginForm(context),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'Don´t have an account?',
                        ),
                        CustomTextButton(
                          text: 'Sign Up',
                          onPressed: () {
                            router.pushNamed(Routes.REGISTER);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ),
          ),
        );
      },
    );
  }
}
