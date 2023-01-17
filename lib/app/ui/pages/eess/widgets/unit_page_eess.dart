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
import 'package:ja_app/app/ui/pages/eess/controller/unit_page_controller.dart';
import 'package:ja_app/app/ui/pages/eess/controller/unit_page_state.dart';
import 'package:ja_app/app/ui/pages/eess/eess_page.dart';
import 'package:ja_app/app/ui/pages/eess/widgets/section_unit_page_eess.dart';
import 'package:ja_app/app/ui/pages/studentes_list/widgets/item_member.dart';
import 'package:ja_app/app/utils/MyColors.dart';

import '../../../../domain/models/country.dart';

final unitPageProvider = StateProvider<UnitPageController, UnitPageState>(
    (_) => UnitPageController(sessionProvider.read, eeSsProvider.read),
    autoDispose: true);

class UnitPageEESS extends StatelessWidget {
  const UnitPageEESS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("se construye");
    return Container(
      height: double.infinity,
      color: Colors.white,
      child: Expanded(
        child: FutureBuilder(
          future: unitPageProvider.read.loadPageData(),
          builder: (context, AsyncSnapshot snapshot) {
            log("otra");
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: CustomTitle2(
                                title: "Unidades de Acción",
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Consumer(builder: (_, watch, __) {
                                final response = watch.select(
                                  unitPageProvider.select(
                                      (state) => state.listUnitOfAction),
                                );
                                log(response.length.toString());
                                final combo = SettingsWidgetV2(
                                  items: response,
                                  value: true,
                                  //value: snapshot.data!.first,
                                  onChanged: (v) {
                                    unitPageProvider.read
                                        .onChangedUnitOfAction(v);
                                  },
                                  hint: 'Unidad de Acciósn',
                                );

                                return combo;
                              }),
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
                              colorBorderButton:
                                  CustomColorPrimary().materialColor,
                              width: 60,
                              height: 48,
                              colorButton: Colors.white,
                              onPressed: () {
                                CustomDialogSimple(
                                    context, "Añadir Unidad de Acción",
                                    content: FutureBuilder<List<UserData>?>(
                                      future: unitPageProvider.read
                                          .getListMembers(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final List<UserData> list =
                                              snapshot.data!;
                                          return Form(
                                            key: unitPageProvider.read
                                                .formKeyRegisterUnitOfAction,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CustomImputField(
                                                  onChanged: unitPageProvider
                                                      .read
                                                      .onChangedNameCreateUnitOfAction,
                                                  label:
                                                      "Nombre Unidad de Acción",
                                                  validator: (text) {
                                                    if (text == "")
                                                      return "El codigo es necesario";
                                                    text = text!
                                                        .replaceAll(" ", "");
                                                    return null;
                                                  },
                                                ),
                                                SettingsWidget(
                                                  onChanged: (v) {
                                                    unitPageProvider.read
                                                        .onChangedUserDateCreateUnitOfAction(
                                                            v);
                                                    log("se hace un on cahnged");
                                                  },
                                                  hint: 'Escoja una clase',
                                                  items: list,
                                                  validator: (text) {
                                                    if (text == null)
                                                      return "Seleccione una clase";
                                                    return null;
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Text("Cargando clases...");
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
                                              colorButton: Color.fromARGB(
                                                  255, 204, 201, 201),
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
                                              unitPageProvider.read
                                                  .onPressedRegisterUnitOfAction(
                                                      context);
                                            },
                                          ))
                                        ],
                                      )
                                    ]).showAlertDialog();
                                //showAlertDialog(context, "", "");
                                //router.pushNamed(Routes.REGISTER);
                              },
                            )
                          ],
                        ),
                      ),
                      /*SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child:
                                    Row(children: buildCards(snapshot.data!)),
                              ),
                            ),*/
                      Divider(),
                      Consumer(builder: (_, watch, __) {
                        final unitOfAction = watch.select(
                          unitPageProvider
                              .select((state) => state.unitOfAction),
                        );
                        if (unitOfAction != null) {
                          return SingleChildScrollView(
                            child:
                                SectionUnitPageEESS(unitOfAction: unitOfAction),
                          );
                        } else {
                          return SizedBox();
                        }
                      }),

                      /*Expanded(
                              child: Container(
                                color: Colors.grey.shade100,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    //padding: const EdgeInsets.only(top: 20),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      log("otra veeee");
                                      return ItemMemberV2(
                                          snapshot.data![index]);
                                    }),
                              ),
                            ),*/
                    ]),
              );
            } else {
              return CustomButton(
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
                  CustomDialogSimple(context, "Añadir Unidad de Acción",
                      content: FutureBuilder<List<UserData>?>(
                        future: unitPageProvider.read.getListMembers(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final List<UserData> list = snapshot.data!;
                            return Form(
                              key: unitPageProvider
                                  .read.formKeyRegisterUnitOfAction,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomImputField(
                                    onChanged: unitPageProvider
                                        .read.onChangedNameCreateUnitOfAction,
                                    label: "Nombre Unidad de Acción",
                                    validator: (text) {
                                      if (text == "")
                                        return "El codigo es necesario";
                                      text = text!.replaceAll(" ", "");
                                      return null;
                                    },
                                  ),
                                  SettingsWidget(
                                    onChanged: (v) {
                                      unitPageProvider.read
                                          .onChangedUserDateCreateUnitOfAction(
                                              v);
                                      log("se hace un on cahnged");
                                    },
                                    hint: 'Escoja una clase',
                                    items: list,
                                    validator: (text) {
                                      if (text == null)
                                        return "Seleccione una clase";
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Text("Cargando clases...");
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
                                unitPageProvider.read
                                    .onPressedRegisterUnitOfAction(context);
                              },
                            ))
                          ],
                        )
                      ]).showAlertDialog();
                  //showAlertDialog(context, "", "");
                  //router.pushNamed(Routes.REGISTER);
                },
              );
            }
          },
        ),
      ),
    );
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
