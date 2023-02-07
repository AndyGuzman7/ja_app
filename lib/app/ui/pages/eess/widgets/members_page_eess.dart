import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/CustomTextField.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_button.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_input_field.dart';
import 'package:ja_app/app/ui/gobal_widgets/item/item_list_view.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/pages/eess/controller/eess_state.dart';
import 'package:ja_app/app/ui/pages/eess/controller/members_page_controller/members_page_controller.dart';
import 'package:ja_app/app/ui/pages/eess/eess_page.dart';
import 'package:ja_app/app/ui/pages/eess/widgets/unit_page_eess.dart';
import 'package:ja_app/app/ui/pages/studentes_list/widgets/item_member.dart';
import 'package:ja_app/app/ui/routes/routes.dart';
import 'package:ja_app/app/utils/MyColors.dart';
import '../controller/eess_controller.dart';

class MembersPageEESS extends StatelessWidget {
  final StateProvider<EeSsController, EeSsState> providers;
  const MembersPageEESS({Key? key, required this.providers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: membersPageProvider.read.loadPageData(),
            builder: (context, AsyncSnapshot snapshot) {
              log("ESPERANDO");
              if (snapshot.connectionState == ConnectionState.done) {
                log("asdadasdadasdasdas");
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                            colorBorderButton:
                                CustomColorPrimary().materialColor,
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
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: CustomImputField(
                                icon: const Icon(Icons.search),
                                label: "Busca por nombre o apellido",
                                /* validator: (text) {
                                      if (text == "") return "El apellido es necesario";
                                      text = text!.replaceAll(" ", "");
                                      return isValidName(text) ? null : "Apellido Invalido";
                                                          },*/
                                //onChanged: controller.onlastNameChanged,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20, left: 10),
                            child: PopupMenuButton(
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 48,
                                      padding: EdgeInsets.all(5),
                                      color: CustomColorPrimary().materialColor,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.filter_list_alt,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Consumer(
                                      builder: (_, watch, __) {
                                        final title = watch.select(
                                          eeSsProvider.select(
                                              (state) => state.titleSearch),
                                        );

                                        return Container(
                                            alignment: Alignment.center,
                                            height: 48,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey.shade400,
                                                    width: 1)),
                                            child: Text(title ?? 'Todos'));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              itemBuilder: (ctx) => [
                                _buildPopupMenuItem('Todos'),
                                _buildPopupMenuItem('Por Unidad'),
                                _buildPopupMenuItem('Lideres'),
                                _buildPopupMenuItem('Sin Unidad'),
                              ],
                              onSelected: ((value) {
                                log(value.toString() + "sadasda");
                              }),
                            ),
                          ),
                        ],
                      ),
                      Consumer(builder: (_, watch, __) {
                        final response = watch.select(
                          membersPageProvider
                              .select((state) => state.membersEESS),
                        );

                        if (response.isEmpty) {
                          return Container(
                            child: Text("No hay miembros"),
                          );
                        } else {
                          return Expanded(
                            child: Container(
                              color: Colors.grey.shade100,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  //padding: const EdgeInsets.only(top: 20),
                                  itemCount: response.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    log("otra veeee");
                                    return ItemMemberV2(response[index]);
                                  }),
                            ),
                          );
                        }
                      })
                    ]);
              } else {
                return willPopScope();
              }
            },
          )),
        ],
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

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(
      child: Text(title),
      onTap: () {
        eeSsProvider.read.onChangedTitleSearch(title);
      },
    );
  }

  List<Widget> itemsBuild(List<UserData> items) {
    /*List<Widget> itemsWidgets = [];
    for (var element in items) {
      itemsWidgets.add(ItemMemberV3(element, false, (user) {
        membersPageProvider.read.onChangedListMembersSelected(user);
      }));
    }*/
    return items
        .map((e) => ItemMemberV3(
            e, false, membersPageProvider.read.onChangedListMembersSelected))
        .toList();
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
                  future: membersPageProvider.read.membersPageFunctions
                      .getMembersNoneEESS(),
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
                                textButton: 'Añadir miembro/oss',
                                colorButton: CustomColorPrimary().materialColor,
                                // colo: Colors.white54,
                                onPressed: () async {
                                  if (membersPageProvider
                                      .read.state.membersEESSNew.isNotEmpty) {
                                    await membersPageProvider.read
                                        .onPressedBtnAddMembers(context);
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
                  onPressed: () async {
                    membersPageProvider.read.onPressedBtnCreateMember(context);
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
