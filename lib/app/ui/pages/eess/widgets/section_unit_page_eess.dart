import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/dialogs.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_button.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_input_field.dart';
import 'package:ja_app/app/ui/gobal_widgets/item/item_list_view.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/pages/church/controller/church_controller.dart';
import 'package:ja_app/app/ui/pages/eess/eess_page.dart';
import 'package:ja_app/app/ui/pages/studentes_list/widgets/item_member.dart';
import 'package:ja_app/app/ui/routes/routes.dart';
import 'package:ja_app/app/utils/MyColors.dart';

class SectionUnitPageEESS extends StatelessWidget {
  final UnitOfAction unitOfAction;
  const SectionUnitPageEESS({Key? key, required this.unitOfAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("se cosntrue la seccion");
    return Column(
      children: [
        card("Clase de EESS", unitOfAction.name, null),
        Divider(),
        Padding(
          padding:
              const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
          child: Row(children: [
            Expanded(
              child: CustomTitle2(title: "Miembros"),
            ),
            CustomButton(
              icon: Icon(
                Icons.person_add,
                color: CustomColorPrimary().materialColor,
                size: 25,
              ),
              colorBorderButton: CustomColorPrimary().materialColor,
              width: 60,
              height: 48,
              colorButton: Colors.white,
              onPressed: () {
                showAlertDialog(context, "", "");
                //router.pushNamed(Routes.REGISTER);
              },
            )
          ]),
        ),
        Divider(),
        FutureBuilder(
            future: eeSsProvider.read.getMembersToUnitOfAction(unitOfAction.id),
            builder: (context, AsyncSnapshot<List<UserData>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Container(
                    child: Text("No hay miembros"),
                  );
                } else {
                  return Container(
                    height: snapshot.data!.length <= 2 ? 100 : 200,
                    width: double.infinity,
                    // width: 300,
                    color: Colors.grey.shade100,
                    child: Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        //padding: const EdgeInsets.only(top: 20),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemMemberV2(snapshot.data![index]);
                        },
                      ),
                    ),
                  );
                }
              } else {
                return Container(height: 200, child: willPopScope());
              }
            }),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomTitle2(title: "Metas"),
              ),
            ),
          ]),
        ),
        subTitle('Comunión'),
        cardTerm(
            "N° de miembros con suscripción a la lección de Escuela Sabática",
            "0"),
        SizedBox(
          height: 10,
        ),
        cardTerm("N° de miembros que estudian la lección diariamente", "0"),
        subTitle('Relacionamiento'),
        cardTerm("N° de miembros que participan de un GP", "0"),
        SizedBox(
          height: 10,
        ),
        cardTerm("N° de miembros que participan de una Unidad de acción", "0"),
        subTitle('Misión'),
        cardTerm("N° de parejas misioneras en la Unidad de Acción", "0"),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  card(title, subtitle, dynamic object) {
    return InkWell(
      child: Container(
        width: double.infinity,
        //color: CustomColorPrimary().materialColor,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(right: 20, left: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustomColorPrimary().materialColor,
        ),
        child: InkWell(
          onTap: (() {
            // eeSsProvider.read.onChangedUnitOfAction(object);
          }),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            ],
          ),
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

  Widget subTitle(title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Icon(Icons.keyboard_arrow_right_outlined),
        Expanded(
          child: CustomTitle3(title: title),
        ),
      ]),
    );
  }

  Widget cardTerm(title, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        //width: 50,
        //color: CustomColorPrimary().materialColor,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustomColorPrimary().materialColor,
        ),
        child: InkWell(
          onTap: (() {
            //eeSsProvider.read.onChangedUnitOfAction(object);
          }),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Text(value),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialogMembers(
      BuildContext contextFather, String text, String? message) {
    showDialog(
      barrierDismissible: false,
      context: contextFather,
      useRootNavigator: false,
      builder: (context) {
        final GlobalKey<FormState> formKey = GlobalKey();
        return AlertDialog(
            contentPadding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            titleTextStyle: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
            title: Text(
              text,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.white,
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              FutureBuilder(
                  future: eeSsProvider.read
                      .getMembersNoneUnitOfAction(unitOfAction.id),
                  builder: (context, AsyncSnapshot<List<UserData>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return Container(
                          child: Text("No hay miembros"),
                        );
                      } else {
                        return Container(
                          width: double.maxFinite,
                          height: 300,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  children: itemsBuild(snapshot.data!),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              CustomButton(
                                height: 48,
                                textButton: 'Añadir miembro/os',
                                colorButton: CustomColorPrimary().materialColor,
                                // colo: Colors.white54,
                                onPressed: () async {
                                  if (eeSsProvider.read.state
                                      .membersUnitOfActionNew.isNotEmpty) {
                                    await eeSsProvider.read
                                        .onPressedAddMembers(context);
                                    router.pop(context);
                                  }
                                },
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          ),
                        );
                      }
                    } else {
                      return Container(height: 200, child: willPopScope());
                    }
                  }),
              CustomButton(
                height: 48,
                textButton: 'Cancelar',
                colorTextButton: CustomColorPrimary().materialColor,
                colorButton: Colors.white54,
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ]));
      },
    );
  }

  itemsBuild(List<UserData> items) {
    List<Widget> itemsWidgets = [];
    for (var element in items) {
      itemsWidgets.add(ItemMemberV3(element, false, (user) {
        eeSsProvider.read.onChangedListMembersSelected(user);
      }));
    }
    return itemsWidgets;
  }

  showAlertDialog(BuildContext contextFather, String text, String? message) {
    showDialog(
      barrierDismissible: false,
      context: contextFather,
      builder: (context) {
        final GlobalKey<FormState> formKey = GlobalKey();
        return AlertDialog(
          iconPadding: EdgeInsets.only(left: 15, right: 15, top: 10),
          icon: Icon(
            Icons.person_add,
            size: 40,
            color: CustomColorPrimary().materialColor,
          ),
          contentPadding:
              EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
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
            // key: churchProvider.read.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                  height: 48,
                  icon: Icon(Icons.person_add),
                  textButton: 'Añadir Miembro',
                  onPressed: () {
                    showAlertDialogMembers(
                        contextFather,
                        "Mantenga presionado para seleccionar/deseleccionar",
                        "");
                    //churchProvider.read.onRegister(contextFather);
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                CustomButton(
                  icon: Icon(Icons.person_add_alt),
                  height: 48,
                  textButton: 'Crear Miembro',
                  onPressed: () {
                    router.pushNamed(Routes.REGISTER);
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                CustomButton(
                  height: 48,
                  textButton: 'Cancelar',
                  colorTextButton: CustomColorPrimary().materialColor,
                  colorButton: Colors.white54,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
