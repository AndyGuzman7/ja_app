import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:intl/intl.dart';
import 'package:ja_app/app/domain/models/eess/quarter.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/target_virtual/target_virtual.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/atribute_data/atribute_data.dart';
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
import 'package:ja_app/app/ui/pages/eess/widgets/widget_attendance.dart';
import 'package:ja_app/app/ui/pages/eess/widgets/widget_date.dart';
import 'package:ja_app/app/ui/pages/eess/widgets/widget_information.dart';
import 'package:ja_app/app/ui/pages/eess/widgets/widget_offering.dart';
import 'package:ja_app/app/ui/pages/studentes_list/widgets/item_member.dart';
import 'package:ja_app/app/ui/routes/routes.dart';
import 'package:ja_app/app/utils/MyColors.dart';

import '../../../../utils/date_controller.dart';
import '../../../gobal_widgets/row/row_custom.dart';
import '../../home/widgets/item_button.dart';

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
