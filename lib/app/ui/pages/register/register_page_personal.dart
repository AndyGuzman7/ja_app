import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/brochure.dart';
import 'package:ja_app/app/domain/models/country.dart';
import 'package:ja_app/app/domain/models/date.dart';
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

import 'package:ja_app/app/utils/name_validator.dart';
import 'package:ja_app/pages/photoUpload.dart';

import '../../gobal_widgets/drop_dow/custom_dropDown.dart';
import '../../gobal_widgets/inputs/custom_radioButton.dart';

class RegisterPagePersonal extends StatelessWidget {
  BuildContext context;
  RegisterPagePersonal({required this.context, Key? key}) : super(key: key);

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

        Row rowModelThree(widgetOne, widgetTwo, widgetThree) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: widgetOne,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(child: widgetTwo),
              const SizedBox(
                width: 10,
              ),
              Expanded(child: widgetTwo),
            ],
          );
        }

        return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              //key: controller.formKey,
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  const CustomTitle2(
                    title: "Hola, Bienvenido de nuevo",
                    subTitle: "Ingresa tu información personal",
                    colorSubTitle: Color.fromARGB(255, 117, 117, 117),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: const Text(
                      "Nombre completo",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  CustomImputField(
                    icon: const Icon(Icons.person),
                    label: "Primer nombre",
                    onChanged: controller.onNameChanged,
                    validator: (text) {
                      if (text == "") return "El nombre es necesario";
                      text = text!.replaceAll(" ", "");
                      return isValidName(text) ? null : "Nombre invalido";
                    },
                  ),
                  CustomImputField(
                    icon: const Icon(Icons.person),
                    label: "Segundo nombre (si cuenta con uno)",
                    onChanged: controller.onNameSecondChanged,
                    validator: (text) {
                      if (text != "") {
                        text = text!.replaceAll(" ", "");
                        return isValidName(text) ? null : "invalid last name";
                      }
                    },
                  ),
                  CustomImputField(
                    icon: const Icon(Icons.person),
                    label: "Primer apellido",
                    validator: (text) {
                      if (text == "") return "El apellido es necesario";
                      text = text!.replaceAll(" ", "");
                      return isValidName(text) ? null : "Apellido Invalido";
                    },
                    onChanged: controller.onlastNameChanged,
                  ),
                  CustomImputField(
                    icon: const Icon(Icons.person),
                    label: "Segundo apellido (si cuenta con uno)",
                    validator: (text) {
                      if (text != "") {
                        text = text!.replaceAll(" ", "");

                        return isValidName(text) ? null : "invalid last name";
                      }
                    },
                    onChanged: controller.onLastNameSecondChanged,
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
                            callback: controller.onSingingCharacterChanged,
                            title: "Hombre",
                            character: SingingCharacter.male,
                          ),
                          CustomRadioButtons<SingingCharacter>(
                            value: s,
                            callback: controller.onSingingCharacterChanged,
                            title: "Mujer",
                            character: SingingCharacter.female,
                          ),
                        ),
                      )
                    ]);
                  }),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: const Text(
                      "Fecha nacimiento",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  CustomImputDatePicker(
                    label: "01-01-2000",
                    onChanged: controller.onBirthDateChanged,
                  ),
                  CustomDropDown<Country>(
                    onChanged: (v) {},
                    hint: 'Pais',
                    lisItems: [Country("Bolivia", "+591")],
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

                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    textButton: 'Registrar',
                    onPressed: () => controller.sendRegisterForm(context),
                  )
                ],
              ),
            ));
      },
    );
  }
}
