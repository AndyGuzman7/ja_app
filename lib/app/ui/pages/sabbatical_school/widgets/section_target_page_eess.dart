import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ja_app/app/domain/models/eess/quarter.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/ui/pages/sabbatical_school/widgets/widget_attendance.dart';
import 'package:ja_app/app/ui/pages/sabbatical_school/widgets/widget_information.dart';
import 'package:ja_app/app/ui/pages/sabbatical_school/widgets/widget_offering.dart';

import '../controller/target_page_controller/target_page_controller.dart';

class SectionTargetPageEESS extends StatelessWidget {
  final List<String> listPermissons;
  UnitOfAction uniOfAction;
  SectionTargetPageEESS(
    this.listPermissons, {
    required this.uniOfAction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: targetPageProvider.read.initPageSectionTargetVirtual(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final listQuarter = targetPageProvider.read.state.listQuarter;
            if (listQuarter.isEmpty) {
              return Text("No hay trimestres habilitados");
            }
            final Quarter? quarter = targetPageProvider.read.state.quarter;
            return Column(children: [
              WidgetInformation(quarter!, uniOfAction,
                  targetPageProvider: targetPageProvider),
              WidgetOffering(quarter),
              WidgetAttendance(targetPageProvider: targetPageProvider),
            ]);
          }
          return Text("sas");
        });
  }
}
