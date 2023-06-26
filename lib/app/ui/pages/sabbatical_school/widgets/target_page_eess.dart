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
import 'package:ja_app/app/ui/pages/sabbatical_school/widgets/section_target_page_eess.dart';
import 'package:ja_app/app/ui/pages/studentes_list/widgets/item_member.dart';
import 'package:ja_app/app/utils/MyColors.dart';

import '../../../../domain/models/country.dart';
import '../controller/members_page_controller/members_page_controller.dart';
import '../controller/target_page_controller/target_page_controller.dart';

class TargetPageEESS extends StatelessWidget {
  final List<String> listPermissons;
  const TargetPageEESS(this.listPermissons, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.white,
      child: FutureBuilder(
        future: targetPageProvider.read.initPageMain(listPermissons),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer(builder: (_, watch, __) {
              final response = watch.select(
                targetPageProvider.select((state) => state.listUnitOfAction),
              );

              if (response.isNotEmpty) {
                bool isTeacher = listPermissons.contains("teacherUnit");
                log("es profe x2" + isTeacher.toString());
                if (isTeacher) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: CustomTitle(
                            title: "Mi Tarjeta de mi Unidad",
                            subTitle: "Usted es lider de unidad.",
                          ),
                        ),
                        Divider(),
                        Consumer(builder: (_, watch, __) {
                          final unitOfAction = watch.select(
                            targetPageProvider
                                .select((state) => state.unitOfActionSelected),
                          );
                          if (unitOfAction != null) {
                            return SingleChildScrollView(
                              child: SectionTargetPageEESS(
                                listPermissons,
                                uniOfAction: unitOfAction,
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                      ],
                    ),
                  );
                } else {
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
                                    targetPageProvider.read
                                        .onChangedUnitOfActionSelected(v);
                                  },
                                  hint: 'Unidad de Acción',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Consumer(builder: (_, watch, __) {
                          final unitOfAction = watch.select(
                            targetPageProvider
                                .select((state) => state.unitOfActionSelected),
                          );
                          if (unitOfAction != null) {
                            return SingleChildScrollView(
                              child: SectionTargetPageEESS(
                                listPermissons,
                                uniOfAction: unitOfAction,
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                      ],
                    ),
                  );
                }
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "No existe unidades de Acción",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
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
}
