import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/custom_input_field.dart';
import 'package:ja_app/app/ui/pages/register/controller/register_controller.dart';
import 'package:ja_app/app/ui/pages/register/controller/register_state.dart';
import 'package:ja_app/app/ui/pages/register/utils/send_register_form.dart';
import 'package:ja_app/app/utils/email_validator.dart';
import 'package:ja_app/app/utils/name_validator.dart';

final registerProvider = StateProvider<RegisterController, RegisterState>(
  (_) => RegisterController(sessionProvider.read),
);

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<RegisterController>(
        provider: registerProvider,
        builder: (_, controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
                child: Form(
                  key: controller.formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(15),
                    children: [
                      CustomImputField(
                        label: "Name",
                        onChanged: controller.onNameChanged,
                        validator: (text) {
                          if (text == null) return "invalid name";
                          return isValidName(text) ? null : "invalid name";
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomImputField(
                        label: "Last Name",
                        validator: (text) {
                          if (text == null) return "invalid last name";
                          return isValidName(text) ? null : "invalid last name";
                        },
                        onChanged: controller.onlastNameChanged,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomImputField(
                        label: "Email",
                        inputType: TextInputType.emailAddress,
                        onChanged: controller.onEmailChanged,
                        validator: (text) {
                          if (text == null) return "invalid email";
                          return isValidEmail(text) ? null : "invalid email";
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomImputField(
                        label: "Password",
                        isPassword: true,
                        onChanged: controller.onPasswordChanged,
                        validator: (text) {
                          if (text == null) return "invalid password";
                          if (text.trim().length >= 6) {
                            return null;
                          }
                          return "invalid password";
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Consumer(
                        builder: (_, watch, __) {
                          watch.watch(
                            registerProvider.select((state) => state.password),
                          );

                          return CustomImputField(
                            label: "Verification Password",
                            onChanged: controller.onVPasswordChanged,
                            isPassword: true,
                            validator: (text) {
                              if (text == null) return "invalid password";
                              if (controller.state.password != text) {
                                return "password don't match";
                              }
                              if (text.trim().length >= 6) {
                                return null;
                              }

                              return "invalid password";
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CupertinoButton(
                        child: const Text("Register"),
                        color: Colors.blue,
                        onPressed: () => sendRegisterForm(context),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
