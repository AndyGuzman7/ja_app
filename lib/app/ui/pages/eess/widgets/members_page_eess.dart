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
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/pages/eess/controller/eess_state.dart';
import 'package:ja_app/app/ui/pages/eess/eess_page.dart';
import 'package:ja_app/app/ui/pages/studentes_list/widgets/item_member.dart';
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
            child: Consumer(builder: (_, watch, __) {
              final isSuscribe = watch.select(
                eeSsProvider.select((state) => state.isSuscribeEESSs),
              );

              if (isSuscribe == 1) {
                log("asadasdasdasd");
                return FutureBuilder(
                    future: eeSsProvider.read.getListMembers(),
                    builder: (context, AsyncSnapshot<List<UserData>> snapshot) {
                      log("ESPERANDO");
                      if (snapshot.hasData) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: CustomTitle2(title: "Miembros"),
                                    ),
                                  ),
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
                                    padding:
                                        EdgeInsets.only(right: 20, left: 10),
                                    child: PopupMenuButton(
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 48,
                                              padding: EdgeInsets.all(5),
                                              color: CustomColorPrimary()
                                                  .materialColor,
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
                                                  eeSsProvider.select((state) =>
                                                      state.titleSearch),
                                                );

                                                return Container(
                                                    alignment: Alignment.center,
                                                    height: 48,
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade400,
                                                            width: 1)),
                                                    child:
                                                        Text(title ?? 'Todos'));
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
                              Expanded(
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
                              ),
                            ]);
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
}
