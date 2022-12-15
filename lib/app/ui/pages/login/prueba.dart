import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
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

class Prueba extends StatelessWidget {
  Prueba({Key? key}) : super(key: key);
  final _controller = loginProvider.read;
  @override
  Widget build(BuildContext context) {
    final imageProvider = Image.network(
      'https://publicdomainvectors.org/photos/abstract-shadow-effects-pub.jpg',
    ).image;

    final Image image = Image.asset('assets/images/4302679.jpg');

    return ProviderListener<LoginController>(
      provider: loginProvider,
      builder: (_, controller) {
        double height = MediaQuery.of(_).size.height;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Stack(children: [
              Container(
                height: height,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: image.image, fit: BoxFit.cover)),
                child: Container(
                  height: height,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(146, 255, 255, 255),
                        Color.fromARGB(248, 255, 255, 255),
                        Color.fromARGB(255, 255, 255, 255),
                        Color.fromARGB(255, 255, 255, 255),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 0.2, 0.8, 1],
                    ),
                  ),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: SingleChildScrollView(
                      /* keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,*/
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
                                        onPressed: () => router
                                            .pushNamed(Routes.RESET_PASSWORD),
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
                                    height: 20,
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
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
