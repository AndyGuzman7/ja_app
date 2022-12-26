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

class RegisterPageUser extends StatelessWidget {
  BuildContext context;
  RegisterPageUser({required this.context, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<RegisterController>(
        provider: registerProvider,
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

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                //key: controller.formKey,
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
                      label: "Nombre",
                      onChanged: controller.onNameChanged,
                      validator: (text) {
                        if (text == "") return "El nombre es necesario";
                        text = text!.replaceAll(" ", "");
                        return isValidName(text) ? null : "Nombre invalido";
                      },
                    ),
                    CustomImputField(
                      icon: const Icon(Icons.person),
                      label: "Primer Apellido",
                      validator: (text) {
                        if (text == "") return "El apellido es necesario";
                        text = text!.replaceAll(" ", "");
                        return isValidName(text) ? null : "Apellido Invalido";
                      },
                      onChanged: controller.onlastNameChanged,
                    ),
                    CustomImputField(
                      icon: const Icon(Icons.person),
                      label: "Segundo Apellido (si cuenta con uno)",
                      validator: (text) {
                        if (text != "") {
                          text = text!.replaceAll(" ", "");

                          return isValidName(text) ? null : "invalid last name";
                        }
                      },
                      onChanged: controller.onlastNameChanged,
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
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: const Text(
                        "Genero",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Consumer(builder: (_, watch, __) {
                      final s = watch.select(
                        registerProvider
                            .select((state) => state.singingCharacter),
                      );
                      return Row(children: [
                        Expanded(
                          child: rowModel(
                            CustomRadioButtons<SingingCharacter>(
                              value: s,
                              callback: (v) {
                                registerProvider.read
                                    .onSingingCharacterChanged(v);
                              },
                              title: "Hombre",
                              character: SingingCharacter.male,
                            ),
                            CustomRadioButtons<SingingCharacter>(
                              value: s,
                              callback: (v) {
                                registerProvider.read
                                    .onSingingCharacterChanged(v);
                                log(v.name);
                              },
                              title: "Mujer",
                              character: SingingCharacter.female,
                            ),
                          ),
                        )
                      ]);
                    }),
                    /* CustomDropDownButtonv2(
                      lisItems: ["asdasd", "fsdf"],
                      onChanged: (p0) {},
                    ),*/
                    CustomDropDown<Country>(
                      onChanged: (v) {},
                      hint: 'Pais',
                      lisItems: [Country("Bolivia", "+591")],
                      icon: Icon(Icons.map),
                      validator: (text) {
                        if (text == null) return "El email es necesario";
                      },
                    ),
                    CustomImputField(
                      icon: const Icon(Icons.phone),
                      label: "Numero Celular",
                      validator: (text) {
                        if (text == "") return "El apellido es necesario";
                        text = text!.replaceAll(" ", "");
                        return isValidName(text) ? null : "Apellido Invalido";
                      },
                      onChanged: controller.onlastNameChanged,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Bautizado/a",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Consumer(builder: (_, watch, __) {
                      final s = watch.select(
                        registerProvider
                            .select((state) => state.singingCharacter),
                      );
                      return rowModel(
                        CustomRadioButtons<SingingCharacter>(
                          value: s,
                          callback: (v) {
                            registerProvider.read.onSingingCharacterChanged(v);
                          },
                          title: "Si",
                          character: SingingCharacter.male,
                        ),
                        CustomRadioButtons<SingingCharacter>(
                          value: s,
                          callback: (v) {
                            registerProvider.read.onSingingCharacterChanged(v);
                            log(v.name);
                          },
                          title: "No",
                          character: SingingCharacter.female,
                        ),
                      );
                    }),
                    /* CustomDropDownButtonv2(
                      lisItems: ["asdasd", "fsdf"],
                      onChanged: (p0) {},
                    ),*/

                    /*CustomImputDatePicker(
                      label: 'Fecha de nacimiento',
                      onChanged: controller.onBirthDateChanged,
                      validator: (text) {
                        //print(text);
                        if (text == null) return "invalid last name";
                      },
                    ),*/
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
                        log("message");
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
                    CustomButton(
                      textButton: 'Registrar',
                      onPressed: () => controller.sendRegisterForm(context),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
