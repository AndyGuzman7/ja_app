import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/brochure.dart';
import 'package:ja_app/app/domain/models/country.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/container_image/container_image.dart';
import 'package:ja_app/app/ui/gobal_widgets/drop_dow/custom_dropDownButton%20copy.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_button.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_date_picker.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_input_field.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/pages/register/controller/register_controller.dart';
import 'package:ja_app/app/ui/pages/register/controller/register_state.dart';
import 'package:ja_app/app/ui/pages/register/register_page.dart';

import 'package:ja_app/app/utils/email_validator.dart';
import 'package:ja_app/app/utils/name_validator.dart';

import '../../gobal_widgets/drop_dow/custom_dropDown.dart';
import '../../gobal_widgets/inputs/custom_radioButton.dart';

class RegisterPageUser extends StatefulWidget {
  BuildContext context;
  StateProvider<RegisterController, RegisterState> providerListener;
  RegisterPageUser(
      {required this.context, required this.providerListener, Key? key})
      : super(key: key);

  @override
  State<RegisterPageUser> createState() => _RegisterPageUserState();
}

class _RegisterPageUserState extends State<RegisterPageUser>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderListener<RegisterController>(
        provider: widget.providerListener,
        builder: (_, controller) {
          Row rowModel(widgetOne, widgetTwo) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: widgetOne,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(child: widgetTwo),
              ],
            );
          }

          log("otra vez");

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: controller.formKeyTwo,
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  const CustomTitle2(
                    title: "Hola, Aun nesecitamos mas informacion",
                    subTitle: "Ingresa tu información de usuario",
                    colorSubTitle: Color.fromARGB(255, 117, 117, 117),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomImputField(
                    icon: const Icon(Icons.person),
                    label: "Nombre de usuario (juanPe) Ejemplo",
                    onChanged: controller.onNameUserChanged,
                    validator: (text) {
                      if (text == "") return "El nombre es necesario";
                      text = text!.replaceAll(" ", "");
                      return isValidName(text) ? null : "Nombre invalido";
                    },
                  ),
                  CustomImputField(
                    icon: Icon(Icons.email),
                    label: "Email",
                    inputType: TextInputType.emailAddress,
                    onChanged: controller.onEmailChanged,
                    validator: (text) {
                      if (text == "") return "El email es necesario";
                      text = text!.replaceAll(" ", "");
                      return isValidEmail(text) ? null : "Email invalido";
                    },
                  ),
                  CustomImputField(
                    icon: Icon(Icons.security),
                    label: "Contraseña",
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
                      log("comprobando contraseña");
                      return CustomImputField(
                        icon: Icon(Icons.security),
                        label: "Verificación contraseña",
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
                  rowModel(
                    CustomButton(
                      height: 48,
                      colorButton: const Color.fromARGB(255, 188, 188, 188),
                      textButton: 'Anterior',
                      onPressed: () => controller.lastPagePersonal(context),
                    ),
                    CustomButton(
                      height: 48,
                      textButton: 'Registrar',
                      onPressed: () => controller.sendRegisterForm(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
