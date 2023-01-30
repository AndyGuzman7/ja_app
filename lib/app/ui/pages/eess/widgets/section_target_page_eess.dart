import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:intl/intl.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/dialogs.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_button.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_date_picker.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_input_field.dart';
import 'package:ja_app/app/ui/gobal_widgets/item/item_list_view.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/pages/church/controller/church_controller.dart';
import 'package:ja_app/app/ui/pages/eess/controller/target_page_controller/target_page_controller.dart';
import 'package:ja_app/app/ui/pages/eess/eess_page.dart';
import 'package:ja_app/app/ui/pages/eess/widgets/unit_page_eess.dart';
import 'package:ja_app/app/ui/pages/studentes_list/widgets/item_member.dart';
import 'package:ja_app/app/ui/routes/routes.dart';
import 'package:ja_app/app/utils/MyColors.dart';

class SectionTargetPageEESS extends StatelessWidget {
  final UnitOfAction unitOfAction;
  const SectionTargetPageEESS({Key? key, required this.unitOfAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataColumn dataColumnCustom() {
      return DataColumn(
          label: Container(
        //width: 200,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              color: CustomColorPrimary().c,
              child: Row(
                children: [
                  Text(
                    "Sábado",
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_circle),
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text("data"),
              //padding: EdgeInsets.only(top: 5),
            )
          ],
        ),
      ));
    }

    return Column(
      children: [
        // card("Nombre de Unidad", unitOfAction.name, null),
        //Divider(),
        Padding(
          padding: const EdgeInsets.only(
            top: 5,
            left: 20,
            right: 20,
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomTitle2(title: "Asistencia"),
              ),
              Expanded(
                child: CustomButton(
                  icon: Icon(
                    Icons.checklist_rounded,
                    color: CustomColorPrimary().materialColor,
                    size: 25,
                  ),
                  colorTextButton: CustomColorPrimary().materialColor,
                  textButton: "LLamar Lista",
                  colorBorderButton: CustomColorPrimary().materialColor,
                  // width: 60,
                  height: 48,
                  colorButton: Colors.white,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CustomTitle(title: "LLamar lista"),
                              Row(
                                children: [
                                  Text("Fecha:"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: CustomImputDatePicker(
                                      label: DateFormat.yMEd("ES")
                                          .format(DateTime.now()),
                                      // onChanged: controller.onBirthDateChanged,
                                      validator: (text) {
                                        if (text == null)
                                          return "Es necesario una fecha";
                                        if (text.weekday != 6) {
                                          return "Seleccione un día sábado";
                                        }

                                        if (text.day < DateTime.now().day) {
                                          return "Seleccione un día sábado";
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomButton(
                                    textButton: "Guardar",
                                    width: 100,
                                    height: 48,
                                    onPressed: () {
                                      targetPageProvider.read
                                          .onPressedButtonSave();
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  FutureBuilder(
                                    future: targetPageProvider.read
                                        .loadDataAttendanceAction(),
                                    builder: (context,
                                        AsyncSnapshot<void> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Consumer(
                                          builder: (context, ref, child) {
                                            final response = ref.select(
                                              targetPageProvider.select(
                                                  (state) => state
                                                      .membersUnitOfAction),
                                            );

                                            if (response.isEmpty) {
                                              return Text("No hay miembros");
                                            }
                                            return Container(
                                              width: double.maxFinite,
                                              height: 300,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: ListView(
                                                      children:
                                                          itemsBuild(response),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }

                                      return Container(
                                          height: 200, child: willPopScope());
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Expanded(
                child: CustomImputField(
                  icon: const Icon(Icons.search),
                  label: "Busca por nombre o apellido",
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_circle_left_outlined)),
              Text("Enero"),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_circle_right_outlined)),
              CustomButton(
                textButton: "Hoy",
                width: 65,
                height: 48,
                onPressed: () {},
              ),
            ],
          ),
        ),
        Divider(),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 1,
            headingRowHeight: 80,
            //sortColumnIndex: 2,
            //sortAscending: false,
            columns: [
              DataColumn(
                  label: Container(
                child: Text("Miembros"),
                width: 200,
              )),
              dataColumnCustom(),
              dataColumnCustom(),
              dataColumnCustom(),
              dataColumnCustom(),
              dataColumnCustom(),
              dataColumnCustom(),
              dataColumnCustom(),
              dataColumnCustom(),
              dataColumnCustom(),
              dataColumnCustom(),
              dataColumnCustom(),
              dataColumnCustom(),
            ],
            rows: [
              DataRow(selected: true, cells: [
                DataCell(Text("Andres"), showEditIcon: true),
                DataCell(Text("Cruz")),
                DataCell(Text("Cruz")),
                DataCell(Text("Cruz")),
                DataCell(Text("28")),
                DataCell(Text("Cruz")),
                DataCell(Text("Cruz")),
                DataCell(Text("Cruz")),
                DataCell(Text("28")),
                DataCell(Text("Cruz")),
                DataCell(Text("Cruz")),
                DataCell(Text("Cruz")),
                DataCell(Text("28"))
              ]),
            ],
          ),
        )
        /*Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomTitle2(title: "Metas"),
              ),
            ),
          ]),
        ),*/
        /*subTitle('Comunión'),
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
        ),*/
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
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.white,
              ),
              Text(
                "Lider de Unidad",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: unitPageProvider.read.getUser(unitOfAction.leader),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return carUser(snapshot.data);
                  }
                  return Container(
                      height: 50,
                      child: willPopScope(isColorBackground: false));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget carUser(UserData user) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          width: 50,
          height: 50,
          child: Container(
            child: CircleAvatar(
              child: Image.network(user.photoURL),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name + " " + user.lastName,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              /*Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        user.email + " " + user.lastName,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 123, 123, 123)),
                      )),
                  Text(
                    "Usuario registrado",
                    style: TextStyle(color: Color.fromARGB(255, 13, 97, 167)),
                  )*/
            ],
          ),
        ),
      ],
    );
  }

  Widget willPopScope({bool isColorBackground = true}) {
    return WillPopScope(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: isColorBackground
            ? const Color.fromARGB(255, 255, 255, 255)
            : Colors.transparent,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: !isColorBackground ? Colors.white : null,
        ),
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
                  future: unitPageProvider.read.getMembersNoneUnitOfAction(),
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
                                child: Column(
                                  children: itemsBuild(snapshot.data!),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              CustomButton(
                                height: 48,
                                textButton: 'Añadir miembro/oss',
                                colorButton: CustomColorPrimary().materialColor,
                                // colo: Colors.white54,
                                onPressed: () async {
                                  if (unitPageProvider.read.state
                                      .membersUnitOfActionNew.isNotEmpty) {
                                    await unitPageProvider.read
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
    log("se renderiza de nuevo");
    List<Widget> itemsWidgets = [];
    for (var element in items) {
      itemsWidgets.add(ItemMemberV4(element, false, (user, state) {
        targetPageProvider.read.changedStateMember(user.id, state);
        //unitPageProvider.read.onChangedListMembersSelected(user);
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
