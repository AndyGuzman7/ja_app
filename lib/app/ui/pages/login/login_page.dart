import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/custom_button.dart';
import 'package:ja_app/app/ui/gobal_widgets/custom_input_field.dart';
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
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Colors.black87,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    );
    return ProviderListener<LoginController>(
        provider: loginProvider,
        builder: (_, controller) {
          print("asfdsafsdfsdf");
          return Scaffold(
            body: SafeArea(
                child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                            child: const Text("Forgot Password"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () => sendLoginForm(context),
                            child: const Text("Sign In"),
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
                      ElevatedButton(
                        onPressed: () {
                          router.pushNamed(Routes.REGISTER);
                        },
                        child: const Text("Sign Up"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        style: flatButtonStyle,
                        onPressed: () {},
                        child: Text('Looks like a FlatButton'),
                      )
                    ],
                  ),
                ),
              ),
            )),
          );
        });
  }
}
