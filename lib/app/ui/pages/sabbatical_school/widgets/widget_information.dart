import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:intl/intl.dart';
import 'package:ja_app/app/domain/models/eess/quarter.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/ui/gobal_widgets/load/load.dart';
import 'package:ja_app/app/ui/pages/sabbatical_school/widgets/unit_page_eess.dart';

import '../../../gobal_widgets/atribute_data/atribute_data.dart';
import '../../../gobal_widgets/row/row_custom.dart';
import '../controller/target_page_controller/target_page_controller.dart';
import '../controller/target_page_controller/target_page_state.dart';

class WidgetInformation extends StatelessWidget {
  UnitOfAction unitOfAction;
  Quarter quarter;
  StateProvider<TargetPageController, TargetPageState> targetPageProvider;
  WidgetInformation(this.quarter, this.unitOfAction,
      {required this.targetPageProvider, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: null,
      title: Text(
        "Infomación",
        style: TextStyle(fontSize: 20, color: null),
      ),
      children: [
        RowCustom(
          AtributeDataV2("Año", DateTime.now().year.toString()),
          AtributeDataV2("Trimestre:", quarter.name),
        ),
        AtributeDataV1("Nombre de la unidad", unitOfAction.name),
        FutureBuilder(
          future: unitPageProvider.read.getUser(unitOfAction.leader),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return AtributeDataV1("Maestro/a",
                  snapshot.data.name + " " + snapshot.data.lastName);
            }
            return Container(height: 50, child: Load(isColorBackground: false));
          },
        ),
        AtributeDataV1(
            "Inicio:", DateFormat.yMMMMd("ES").format(quarter.startTime)),
        AtributeDataV1(
            "Cierre:", DateFormat.yMMMMd("ES").format(quarter.endTime)),
      ],
    );
  }
}
