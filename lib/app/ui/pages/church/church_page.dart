import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/CustomTextField.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_button.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/pages/church/controller/church_controller.dart';
import 'package:ja_app/app/utils/MyColors.dart';

import '../../../domain/models/church/church.dart';
import '../../gobal_widgets/inputs/custom_input_field.dart';
import '../../gobal_widgets/text/custom_paragraph.dart';

class ChurchPage extends StatelessWidget {
  const ChurchPage({Key? key}) : super(key: key);

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
            Icons.code_rounded,
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
          content: Form(
            key: churchProvider.read.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImputField(
                  onChanged: churchProvider.read.onChangedCodeAccess,
                  label: "Codigo de registro",
                  validator: (text) {
                    if (text == "") return "El codigo es necesario";
                    text = text!.replaceAll(" ", "");
                    return null;
                  },
                )
              ],
            ),
          ),
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
                    churchProvider.read.onRegister(contextFather);
                  },
                ))
              ],
            )
          ],
        );
      },
    );
  }

  Widget _roundedImage(image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network(image),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //extendBody: true,
//backgroundColor: CustomColorPrimary().materialColor,
      appBar: AppBar(
        excludeHeaderSemantics: false,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        /*title: Text(
          "Mi Iglesia",
          style: TextStyle(color: CustomColorPrimary().materialColor),
        ),*/
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder(
          future: churchProvider.read.getChurchSuscription(),
          builder: (context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Consumer(builder: (_, watch, __) {
                final isSuscribe = watch.select(
                  churchProvider.select((state) => state.isSuscribe),
                );
                if (isSuscribe) {
                  final Church? church = churchProvider.read.state.church;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          color: Colors.black,
                          child: Image.network(
                            church!.photoURL,
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
                              Icons.star,
                              size: 17,
                              color:
                                  CustomColorPrimary().materialColor.shade200,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Región " + church.region.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "(Mision central Boliviano)",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 109, 109, 109)),
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
                              church.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Iglesia Adventista del Septimo Día",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        "Usted es un miembro de esta iglesia",
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
                                paragraph: church.information == ''
                                    ? "Aun no hay Información"
                                    : church.information,
                                colorText: Color.fromARGB(255, 77, 77, 77),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.church_outlined,
                          color: Color.fromARGB(255, 125, 125, 125),
                          size: 30,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "No esta registrado/a en ninguna iglesia",
                          style: TextStyle(
                            color: Color.fromARGB(255, 125, 125, 125),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomButton(
                          onPressed: () {
                            showAlertDialog(context, "Registro en una Iglesia",
                                "Introduce el codigo de registro");
                          },
                          textButton: "Registrarse",
                          height: 48,
                          colorButton: Color.fromARGB(255, 175, 175, 175),
                        )
                      ],
                    ),
                  );
                }
              });
            } else {
              return WillPopScope(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                  onWillPop: () async => false);
            }
          },
        ),
      ),
    );
  }
}
