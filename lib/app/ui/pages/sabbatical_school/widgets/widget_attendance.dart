import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/ui/gobal_widgets/load/load.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/pages/sabbatical_school/widgets/widget_date.dart';
import 'package:ja_app/app/ui/pages/sabbatical_school/widgets/widget_table_attendance.dart';
import 'package:ja_app/app/utils/MyColors.dart';
import 'package:ja_app/app/utils/date_controller.dart';

import '../../../../domain/models/target_virtual/target_virtual.dart';
import '../../../gobal_widgets/inputs/custom_button.dart';
import '../../../gobal_widgets/item/item_list_view.dart';
import '../controller/target_page_controller/target_page_controller.dart';
import '../controller/target_page_controller/target_page_state.dart';

class WidgetAttendance extends StatelessWidget {
  StateProvider<TargetPageController, TargetPageState> targetPageProvider;
  WidgetAttendance({required this.targetPageProvider, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        leading: null,
        title: Text(
          "Asistencia",
          style: TextStyle(fontSize: 20, color: null),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
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
                          return contentModalAttendance(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          FutureBuilder(
            future:
                targetPageProvider.read.loadDataUnitAttendanceSection(context),
            builder: (context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer(builder: (context, ref, child) {
                  final response = ref.select(
                    targetPageProvider
                        .select((state) => state.listUserDataAttendances),
                  );

                  if (response == null) {
                    return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("No hay registros"),
                            ],
                          ),
                        ));
                  } else {
                    return WidgetTableAttendance(response,
                        targetPageProvider.read.state.listSaturdayDateMonth!);
                  }
                });
              }

              return Container(height: 200, child: Load());
            },
          ),
        ]);
  }

  contentModalAttendance(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomTitle(title: "LLamar lista"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Fecha:"),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(255, 240, 240, 240)),
                child: Row(children: [
                  IconButton(
                      onPressed: () {
                        targetPageProvider.read.onPressedLastDateTime(context);
                      },
                      icon: Icon(Icons.arrow_circle_left_rounded)),
                  Consumer(
                    builder: ((context, ref, child) {
                      final response = ref.select(
                        targetPageProvider
                            .select((state) => state.dateTimeSelected),
                      );
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                              scale: animation, child: child);
                        },
                        child: CardDate(
                          date: response!,
                        ),
                      );
                    }),
                  ),
                  IconButton(
                      onPressed: () {
                        targetPageProvider.read.onPressedNextDateTime(context);
                      },
                      icon: Icon(Icons.arrow_circle_right_rounded)),
                ]),
              ),
              Consumer(builder: (context, ref, child) {
                final response = ref.select(
                  targetPageProvider.select((state) => state.dateTimeSelected),
                );

                return CustomButton(
                    textButton: "Guardar",
                    width: 100,
                    height: 48,
                    onPressed: DateController()
                            .compareTwoDates(response!, DateTime.now())
                        ? () {
                            targetPageProvider.read
                                .onPressedBtnRegisterAttendances(context);
                          }
                        : null);
              })
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FutureBuilder(
                future:
                    targetPageProvider.read.initDialogShowAttendance(context),
                builder: (context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Consumer(
                      builder: (context, ref, child) {
                        final response = ref.select(
                          targetPageProvider
                              .select((state) => state.dateTimeSelected),
                        );
                        if (DateController().compareTwoDatesMajorDayExplicity(
                            response!, DateTime.now())) {
                          return SizedBox(
                              height: 200,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                        "No puede llamar lista si no es sábado"),
                                  ],
                                ),
                              ));
                        }

                        return Consumer(builder: (context, ref, child) {
                          final response = ref.select(
                            targetPageProvider.select(
                                (state) => state.listUserDataAttendance),
                          );
                          if (response == null) {
                            return SizedBox(height: 200, child: Load());
                          }
                          if (response.isEmpty) {
                            return SizedBox(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text("No existe Registros"),
                                    ],
                                  ),
                                ));
                          }

                          return Container(
                            width: double.maxFinite,
                            height: 200,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView(
                                    children: itemsBuild(response),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          );
                        });
                      },
                    );
                  }

                  return Container(height: 200, child: Load());
                },
              )
            ],
          )
        ],
      ),
    );
  }

  itemsBuild(List<UserDataAttendance> items) {
    return items
        .map(
          (e) => ItemMemberV4(
            e,
            false,
            (user) {
              if (DateTime.now().day ==
                  targetPageProvider.read.state.dateTimeSelected!.day) {
                targetPageProvider.read.changedStateUserDataAttendance(user);
              }
            },
          ),
        )
        .toList();
  }
}
