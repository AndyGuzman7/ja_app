import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/country.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/ui/gobal_widgets/drop_dow/custom_dropDown.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_button.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_input_field.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_paragraph.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/pages/eess/eess_page.dart';
import 'package:ja_app/app/utils/MyColors.dart';

import '../../../../domain/models/church/church.dart';
import '../controller/eess_controller.dart';
import '../controller/eess_state.dart';

class MainPageEess extends StatelessWidget {
  final StateProvider<EeSsController, EeSsState> provider;
  const MainPageEess({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eessInformation = Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.book_rounded,
            color: Color.fromARGB(255, 125, 125, 125),
            size: 30,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "No pertenece a ninguna Escuela y/o clase sábatica",
            style: TextStyle(
              color: Color.fromARGB(255, 125, 125, 125),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
            onPressed: () {
              showAlertDialog(
                  context,
                  "Registro en una clase de Escuela sábatica",
                  "Introduce el codigo de registro");
            },
            textButton: "Pertenecer a una clase",
            height: 48,
            colorButton: Color.fromARGB(255, 175, 175, 175),
          )
        ],
      ),
    );
    final churchInformation = Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.info,
                color: Color.fromARGB(255, 125, 125, 125),
                size: 30,
              ),
              const SizedBox(
                width: 15,
              ),
              const Text(
                "Es necesario estar registrado en una\niglesia para activar esta función",
                style: TextStyle(
                  color: Color.fromARGB(255, 125, 125, 125),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Icon(
            Icons.church_outlined,
            color: Color.fromARGB(255, 125, 125, 125),
            size: 30,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Presione el boton para ir al panel de Mi Iglesia",
            style: TextStyle(
              color: Color.fromARGB(255, 125, 125, 125),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
            onPressed: () {
              provider.read.onPressedGoToThePanel(context);
            },
            textButton: "Ir al Panel",
            height: 48,
            colorButton: Color.fromARGB(255, 175, 175, 175),
          )
        ],
      ),
    );

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder(
        future: provider.read.isExistSuscription(),
        builder: (context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer(builder: (_, watch, __) {
              final isSuscribe = watch.select(
                provider.select((state) => state.isSuscribeEESS),
              );

              if (isSuscribe) {
                final eess = provider.read.state.eess;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.black,
                        child: Image.network(
                          eess!.photoURL!,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.book,
                            size: 17,
                            color: CustomColorPrimary().materialColor.shade100,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          /* Text(
                              "Región " + eess.region.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),*/
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "(EESS)",
                            style: TextStyle(
                                color: Color.fromARGB(255, 109, 109, 109)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Escuela Sábatica Adventista",
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            eess.name!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Clase de EESS",
                            style: TextStyle(
                                color: Color.fromARGB(255, 109, 109, 109)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider()
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                        //margin: EdgeInsets.all(15),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          //color: CustomColorPrimary().materialColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: double.infinity,
                                //margin: EdgeInsets.all(15),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  color: CustomColorPrimary().materialColor,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check_box_outlined,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Usted es un miembro de esta clase EESS",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )),
                            CustomTitle2(
                              fontSize: 15,
                              title: "Información",
                              isBoldTitle: true,
                              colorTitle: Colors.black,
                            ),
                            CustomParagraph(
                              paragraph: eess.information! == ''
                                  ? "Aun no hay Información"
                                  : eess.information!,
                              colorText: Color.fromARGB(255, 77, 77, 77),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Container(
                  padding: const EdgeInsets.all(15),
                  child: Consumer(
                    builder: (_, watch, __) {
                      final isSuscribe = watch.select(
                        eeSsProvider.select((state) => state.isSuscribeChurch),
                      );
                      if (isSuscribe) {
                        return eessInformation;
                      } else {
                        return churchInformation;
                      }
                    },
                  ),
                );
              }
            });
          } else {
            return willPopScope();
          }
        },
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

  showAlertDialog(BuildContext contextFather, String text, String? message) {
    showDialog(
      barrierDismissible: false,
      context: contextFather,
      builder: (context) {
        final GlobalKey<FormState> formKey = GlobalKey();
        return AlertDialog(
          iconPadding:
              EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 10),
          icon: Icon(
            Icons.book,
            size: 40,
            color: CustomColorPrimary().materialColor,
          ),
          actionsPadding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
          contentPadding:
              EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
          title: Text(
            text,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.white,
          content: FutureBuilder<List<EESS>?>(
              future: provider.read.getEESSs(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<EESS> list = snapshot.data!;
                  return Form(
                    key: eeSsProvider.read.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SettingsWidget(
                          onChanged: (v) {
                            provider.read.onChangedEESS(v);
                            log("se hace un on cahnged");
                          },
                          hint: 'Escoja una clase',
                          items: list,
                          validator: (text) {
                            if (text == null) return "Seleccione una clase";
                            return null;
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return Text("Cargando clases...");
                }
              }),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    height: 48,
                    textButton: 'Cancelar',
                    colorTextButton: CustomColorPrimary().materialColor,
                    colorButton: Colors.white54,
                    onPressed: () {
                      Navigator.pop(context);
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
                    eeSsProvider.read.onRegisterEESS(contextFather);
                  },
                ))
              ],
            )
          ],
        );
      },
    );
  }
}
