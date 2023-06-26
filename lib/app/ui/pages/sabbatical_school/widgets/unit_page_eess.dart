import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/dialogs.dart';
import 'package:ja_app/app/ui/gobal_widgets/drop_dow/custom_dropDown.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_button.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_input_field.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/pages/sabbatical_school/sabbatical_school_page.dart';
import 'package:ja_app/app/ui/pages/sabbatical_school/widgets/section_unit_page_eess.dart';
import 'package:ja_app/app/ui/pages/studentes_list/widgets/item_member.dart';
import 'package:ja_app/app/utils/MyColors.dart';

import '../../../../domain/models/country.dart';
import '../controller/members_page_controller/members_page_controller.dart';
import '../controller/unit_page_controller/unit_page_controller.dart';
import '../controller/unit_page_controller/unit_page_state.dart';

final unitPageProvider = StateProvider<UnitPageController, UnitPageState>(
    (_) =>
        UnitPageController(sessionProvider.read, sabbaticalSchoolProvider.read),
    autoDispose: true);

class UnitPageEESS extends StatelessWidget {
  final List<String> listPermissons;
  const UnitPageEESS({required this.listPermissons, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.white,
      child: FutureBuilder(
        future: unitPageProvider.read.verificationPersmissons(listPermissons),
        builder: (context, AsyncSnapshot snapshot) {
          final state = unitPageProvider.read.state;
          if (snapshot.connectionState == ConnectionState.done) {
            if (state.admin != null) {
              return futureBuilder(context);
            }

            if (state.unitOfActionLeader != null) {
              log("leader");
              return sectionDontAdmin(state.unitOfActionLeader, true);
            }
            if (state.unitOfActionMember != null) {
              return sectionDontAdmin(state.unitOfActionMember, false);
            }

            return sectionDontExist(context);
          }
          return willPopScope();
        },
      ),
    );
  }

  Widget futureBuilder(context) {
    return Consumer(builder: (_, watch, __) {
      final response = watch.select(
        unitPageProvider.select((state) => state.listUnitOfAction),
      );

      if (response.isNotEmpty) {
        return sectionMain(context, response);
      }
      return sectionDontExistAdmin(context);
    });
  }

  Widget sectionDontExistAdmin(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "No existe unidades de Acción\npresione el boton para crear una.",
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        CustomButton(
          icon: Icon(
            Icons.add_circle_outline_sharp,
            color: CustomColorPrimary().materialColor,
            size: 25,
          ),
          colorBorderButton: CustomColorPrimary().materialColor,
          width: 60,
          height: 48,
          colorButton: Colors.white,
          onPressed: () {
            dialogWidget(context);
          },
        ),
      ],
    );
  }

  Widget sectionDontExist(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.info),
        SizedBox(
          height: 20,
        ),
        Text(
          "Aun no pertenece a una Unidad de Acción.",
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        /*CustomButton(
          icon: Icon(
            Icons.add_circle_outline_sharp,
            color: CustomColorPrimary().materialColor,
            size: 25,
          ),
          colorBorderButton: CustomColorPrimary().materialColor,
          width: 60,
          height: 48,
          colorButton: Colors.white,
          onPressed: () {
            dialogWidget(context);
          },
        ),*/
      ],
    );
  }

  Widget sectionDontAdmin(unitOfAction, isAdmin) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: CustomTitle(
              title: "Mi unidad de Acción",
              subTitle: "Usted es miembro de esta unidad.",
            ),
          ),
          SingleChildScrollView(
            child: SectionUnitPageEESS(
              unitOfAction: unitOfAction,
              isAdmin: isAdmin,
            ),
          )
        ],
      ),
    );
  }

  Widget sectionMain(context, response) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CustomTitle2(
              title: "Unidades de Acción",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: SettingsWidget(
                    items: response,
                    //value: true,
                    //value: snapshot.data!.first,
                    onChanged: (v) {
                      unitPageProvider.read.onChangedUnitOfAction(v);
                    },
                    hint: 'Unidad de Acción',
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                CustomButton(
                  icon: Icon(
                    Icons.add_circle_outline_sharp,
                    color: CustomColorPrimary().materialColor,
                    size: 25,
                  ),
                  colorBorderButton: CustomColorPrimary().materialColor,
                  width: 60,
                  height: 48,
                  colorButton: Colors.white,
                  onPressed: () {
                    //unitPageProvider.read.sendEmail();
                    dialogWidget(context);
                  },
                )
              ],
            ),
          ),
          Divider(),
          Consumer(
            builder: (_, watch, __) {
              final unitOfAction = watch.select(
                unitPageProvider.select((state) => state.unitOfAction),
              );
              if (unitOfAction != null) {
                return SingleChildScrollView(
                  child: SectionUnitPageEESS(
                    unitOfAction: unitOfAction,
                    isAdmin: true,
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  dialogWidget(BuildContext context) {
    return CustomDialogSimple(context, "Añadir Unidad de Acción",
        content: FutureBuilder<List<UserData>?>(
          future: unitPageProvider.read.getMembersNoneUnitOfAction(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<UserData> list = snapshot.data!;
              return Form(
                key: unitPageProvider.read.formKeyRegisterUnitOfAction,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomInputField(
                      onChanged:
                          unitPageProvider.read.onChangedNameCreateUnitOfAction,
                      label: "Nombre Unidad de Acción",
                      isNoSpace: false,
                      validator: (text) {
                        if (text == "") return "El nombre es necesario";
                        //text = text!.replaceAll(" ", "");
                        if (text!.substring(text.length - 1, text.length) ==
                            " ") {
                          text = text.replaceRange(text.length, null, "");
                          log(text);
                        }
                        return null;
                      },
                    ),
                    SettingsWidget(
                      onChanged: (v) {
                        unitPageProvider.read
                            .onChangedUserDateCreateUnitOfAction(v);
                      },
                      hint: 'Lider de Unidad de Acción',
                      items: list,
                      validator: (text) {
                        if (text == null) return "Seleccione un lider";
                        return null;
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Text("Cargando...");
            }
          },
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  height: 48,
                  textButton: 'Cancelar',
                  colorTextButton: Colors.white,
                  colorButton: Color.fromARGB(255, 204, 201, 201),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: CustomButton(
                height: 48,
                textButton: 'Registrar',
                onPressed: () {
                  unitPageProvider.read.onPressedRegisterUnitOfAction(context);
                },
              ))
            ],
          )
        ]).showAlertDialog();
  }

  Widget willPopScope() {
    return WillPopScope(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 255, 255, 255),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
      onWillPop: () async => false,
    );
  }
}
