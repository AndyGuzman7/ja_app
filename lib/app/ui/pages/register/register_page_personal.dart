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
import 'package:ja_app/app/utils/email_validator.dart';

import 'package:ja_app/app/utils/name_validator.dart';
import 'package:ja_app/pages/photoUpload.dart';

import '../../gobal_widgets/drop_dow/custom_dropDown.dart';
import '../../gobal_widgets/inputs/custom_radioButton.dart';

class RegisterPagePersonal extends StatefulWidget {
  BuildContext context;
  StateProvider<RegisterController, RegisterState> providerListener;
  RegisterPagePersonal(
      {required this.context, required this.providerListener, Key? key})
      : super(key: key);

  @override
  State<RegisterPagePersonal> createState() => _RegisterPagePersonalState();
}

class _RegisterPagePersonalState extends State<RegisterPagePersonal>
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

        Row rowModelLeft(widgetOne, widgetTwo) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: widgetOne,
              ),
              const SizedBox(
                width: 15,
              ),
              widgetTwo,
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
              key: controller.formKeyOne,
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  rowModelLeft(
                    const CustomTitle2(
                      title: "Hola, Bienvenido de nuevo",
                      subTitle: "Ingresa tu información personal",
                      colorSubTitle: Color.fromARGB(255, 117, 117, 117),
                    ),
                    Consumer(builder: (_, watch, __) {
                      final s = watch.select(
                        registerProvider.select((state) => state.userAvatar),
                      );
                      return Container(
                          width: 50, height: 50, child: Image.network(s!.url));
                    }),
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
                    validator: (text) {
                      if (text == null) return "Es necesario una fecha";
                    },
                  ),
                  SettingsWidget(
                    onChanged: (v) {
                      controller.onCountryChanged(v);
                      log(v.name);
                    },
                    hint: 'Pais',
                    items: [
                      Country("Bolivia", "+591"),
                      Country("Peru", "+51"),
                      Country("Brasil", "+53")
                    ],
                    validator: (text) {
                      if (text == null) return "El Pais es necesario";
                      return null;
                    },
                  ),
                  /* CustomDropDown(
                    onChanged: (v) {
                      controller.onCountryChanged(v);
                    },
                    hint: 'Pais',
                    lisItems: [
                      Country("Bolivia", "+591"),
                      Country("Peru", "+51"),
                      Country("Brasil", "+53")
                    ],
                    validator: (text) {
                      if (text == null) return "El Pais es necesario";
                      return null;
                    },
                  ),*/
                  CustomImputField(
                    onChanged: controller.onPhoneChanged,
                    icon: const Icon(Icons.phone),
                    label: "+591 67893456 (ejemplo)",
                    validator: (text) {
                      if (text == "") return "El celular es necesario";
                      text = text!.replaceAll(" ", "");
                      return isValidPhone(text) ? null : "Celular Invalido";
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: const Text(
                      "Bautizado/a",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Consumer(builder: (_, watch, __) {
                    final s = watch.select(
                      registerProvider
                          .select((state) => state.bautizatedCharacter),
                    );
                    return rowModel(
                      CustomRadioButtons<BautizatedCharacter>(
                        value: s,
                        callback: (v) {
                          registerProvider.read.onBautizatedChanged(v);
                        },
                        title: "Si",
                        character: BautizatedCharacter.yes,
                      ),
                      CustomRadioButtons<BautizatedCharacter>(
                        value: s,
                        callback: (v) {
                          registerProvider.read.onBautizatedChanged(v);
                        },
                        title: "No",
                        character: BautizatedCharacter.no,
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  rowModel(
                    CustomButton(
                      height: 48,
                      colorButton: Color.fromARGB(255, 188, 188, 188),
                      textButton: 'Anterior',
                      onPressed: () => controller.lastPage(context),
                    ),
                    CustomButton(
                      height: 48,
                      textButton: 'Siguiente',
                      onPressed: () => controller.nextPageSend(context),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
