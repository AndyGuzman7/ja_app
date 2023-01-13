import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_input_field.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/pages/eess/eess_page.dart';
import 'package:ja_app/app/ui/pages/eess/widgets/section_unit_page_eess.dart';
import 'package:ja_app/app/ui/pages/studentes_list/widgets/item_member.dart';
import 'package:ja_app/app/utils/MyColors.dart';

class UnitPageEESS extends StatelessWidget {
  const UnitPageEESS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    card(title, subtitle, dynamic object) {
      return InkWell(
        child: Container(
          //width: 50,
          //color: CustomColorPrimary().materialColor,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColorPrimary().materialColor,
          ),
          child: InkWell(
            onTap: (() {
              eeSsProvider.read.onChangedUnitOfAction(object);
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

    buildCards(List<UnitOfAction> unitOfActions) {
      log(unitOfActions.toString());
      List<Widget> list = [];
      for (UnitOfAction element in unitOfActions) {
        list.add(card("Clase de EESS", element.name, element));
      }
      return list;
    }

    return Container(
      height: double.infinity,
      color: Colors.white,
      child: Expanded(
        child: Consumer(builder: (_, watch, __) {
          final isSuscribe = watch.select(
            eeSsProvider.select((state) => state.isSuscribeEESSs),
          );

          if (isSuscribe == 1) {
            return FutureBuilder(
                future: eeSsProvider.read.getEESS(),
                builder: (context, AsyncSnapshot<EESS?> snapshot) {
                  log("ESPERANDO");
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: CustomTitle2(
                                      title: "Unidades de Acción",
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                    children: buildCards(
                                        snapshot.data!.unitOfAction)),
                              ),
                            ),
                            Divider(),
                            Consumer(builder: (_, watch, __) {
                              final unitOfAction = watch.select(
                                eeSsProvider
                                    .select((state) => state.unitOfAction),
                              );
                              if (unitOfAction != null) {
                                return SingleChildScrollView(
                                  child: SectionUnitPageEESS(
                                      unitOfAction: unitOfAction),
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
                    return willPopScope();
                  }
                });
          } else {
            return Column(
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
                      "Es necesario estar registrado en una\nclase de EESS para esta función.",
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
              ],
            );
          }
        }),
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
}
