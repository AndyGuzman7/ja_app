import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/drop_dow/custom_dropDown.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_button.dart';
import 'package:ja_app/app/ui/pages/sabbatical_school/controller/sabbatical_school_state.dart';
import 'package:ja_app/app/utils/MyColors.dart';

import 'controller/sabbatical_school_controller.dart';

final sabbaticalSchoolProvider =
    StateProvider<SabbaticalSchoolController, SabbaticalSchoolState>(
        (_) => SabbaticalSchoolController(sessionProvider.read),
        autoDispose: true);

class SabbaticalSchoolPage extends StatelessWidget {
  const SabbaticalSchoolPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sabbaticalSchoolProvider.read.getChurchAndEESS(),
      builder: (context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer(
            builder: (_, watch, __) {
              final state = watch.select(
                sabbaticalSchoolProvider.select((state) => state),
              );
              if (state.eess == null) {
                return informationEESS(context);
              }

              if (state.church == null) {
                return informationChurch(sabbaticalSchoolProvider, context);
              }

              return DefaultTabController(
                length: sabbaticalSchoolProvider.read.state.listTabr.length,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.blueGrey[50],
                  appBar: AppBar(
                    title: const Text("Escuela Sábatica"),
                    bottom: TabBar(
                      tabs: sabbaticalSchoolProvider.read.state.listTabr,
                    ),
                  ),
                  body: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children:
                          sabbaticalSchoolProvider.read.state.listTabBarView),
                ),
              );
            },
          );
        }
        return willPopScope();
      },
    );
  }

  Widget customScaffold(child) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //extendBody: true,
//backgroundColor: CustomColorPrimary().materialColor,
      appBar: AppBar(
        excludeHeaderSemantics: false,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Mi Iglesia",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: child,
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

  Widget informationEESS(context) {
    final eessInformation = customScaffold(
      Center(
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
                    "Introduce el codigo de registro",
                    sabbaticalSchoolProvider);
              },
              textButton: "Pertenecer a una clase",
              height: 48,
              colorButton: Color.fromARGB(255, 175, 175, 175),
            )
          ],
        ),
      ),
    );

    return eessInformation;
  }

  showAlertDialog(
      BuildContext contextFather,
      String text,
      String? message,
      StateProvider<SabbaticalSchoolController, SabbaticalSchoolState>
          provider) {
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
                    key: sabbaticalSchoolProvider.read.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SettingsWidget(
                          onChanged: (v) {
                            provider.read.onChangedEESSSelected(v);
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
                    sabbaticalSchoolProvider.read.onRegisterEESS(contextFather);
                  },
                ))
              ],
            )
          ],
        );
      },
    );
  }

  Widget informationChurch(provider, context) {
    final churchInformation = customScaffold(
      Center(
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
      ),
    );
    return churchInformation;
  }
}
