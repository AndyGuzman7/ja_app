import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/custom_button.dart';
import 'package:ja_app/app/ui/gobal_widgets/custom_date_picker.dart';
import 'package:ja_app/app/ui/gobal_widgets/custom_input_field.dart';
import 'package:ja_app/app/ui/gobal_widgets/custom_title.dart';
import 'package:ja_app/app/ui/pages/register/controller/register_controller.dart';
import 'package:ja_app/app/ui/pages/register/controller/register_state.dart';
import 'package:ja_app/app/ui/pages/register/utils/send_register_form.dart';
import 'package:ja_app/app/utils/MyColors.dart';
import 'package:ja_app/app/utils/email_validator.dart';
import 'package:ja_app/app/utils/name_validator.dart';
import 'package:ja_app/pages/photoUpload.dart';

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
          Row rowModel(widgetOne, widgetTwo) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: widgetOne),
                const SizedBox(
                  width: 15,
                ),
                Expanded(child: widgetTwo),
              ],
            );
          }

          log("otra vez");

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
            ),
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
                      const CustomTitle2(
                        title: "Hey Welcome back",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              Consumer(builder: (_, watch, __) {
                                final photo = watch.select(
                                  registerProvider.select((_) => _.photo),
                                );
                                Image image;
                                log(photo.toString());
                                if (photo != null) {
                                  image = Image.file(photo);
                                } else {
                                  image = Image.network(
                                      "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png");
                                }

                                return Container(
                                  child: image,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: CustomColorPrimary().materialColor,
                                  ),
                                  width: 80,
                                  height: 80,
                                );
                              }),
                              Positioned(
                                bottom: -13,
                                right: -10,
                                child: Container(
                                  width: 40,
                                  padding: EdgeInsets.zero,
                                  decoration: const ShapeDecoration(
                                    color: Color.fromARGB(233, 203, 229, 241),
                                    shape: CircleBorder(),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.camera_alt),
                                    color: CustomColorPrimary().materialColor,
                                    onPressed: () {
                                      CustomImageProvider customImageProvider =
                                          CustomImageProvider((File file) {
                                        controller.onPhotoChanged(file);
                                      });
                                      customImageProvider.getImageCamera();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      rowModel(
                        CustomImputField(
                          icon: Icon(Icons.person),
                          label: "Name",
                          onChanged: controller.onNameChanged,
                          validator: (text) {
                            if (text == null) return "invalid name";
                            return isValidName(text) ? null : "invalid name";
                          },
                        ),
                        CustomImputField(
                          label: "Last Name",
                          validator: (text) {
                            if (text == null) return "invalid last name";
                            return isValidName(text)
                                ? null
                                : "invalid last name";
                          },
                          onChanged: controller.onlastNameChanged,
                        ),
                      ),
                      CustomImputField(
                        icon: Icon(Icons.email),
                        label: "Email",
                        inputType: TextInputType.emailAddress,
                        onChanged: controller.onEmailChanged,
                        validator: (text) {
                          if (text == null) return "invalid email";
                          return isValidEmail(text) ? null : "invalid email";
                        },
                      ),
                      CustomImputDatePicker(
                        label: 'Date birth day',
                        validator: (text) {
                          //print(text);
                          if (text == null) return "invalid last name";
                        },
                      ),
                      CustomImputField(
                        icon: Icon(Icons.security),
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
                      Consumer(
                        builder: (_, watch, __) {
                          watch.watch(
                            registerProvider.select((state) => state.password),
                          );

                          return CustomImputField(
                            icon: Icon(Icons.security),
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
                        height: 10,
                      ),
                      CustomButton(
                        textButton: 'Register',
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
