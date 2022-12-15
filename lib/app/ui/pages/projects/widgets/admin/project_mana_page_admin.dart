import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/sign_up.dart';
import 'package:ja_app/app/domain/models/brochure.dart';
import 'package:ja_app/app/domain/models/brochureSubscription.dart';
import 'package:ja_app/app/domain/models/subscriptionProjectMana.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/pages/projects/project_mana_page.dart';
import 'package:ja_app/app/ui/pages/projects/widgets/admin/controller/project_mana_page_admin_controller.dart';
import 'package:ja_app/app/ui/pages/projects/widgets/admin/controller/project_mana_page_admin_state.dart';
import 'package:ja_app/app/utils/MyColors.dart';

final projectManaPageAdminProvider =
    StateProvider<ProjectManaAdminController, ProjectManaAdminState>(
        (_) => ProjectManaAdminController());

class ProjectManaPageAdmin extends StatelessWidget {
  const ProjectManaPageAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    card(title, subtitle) {
      return Container(
        color: Color.fromARGB(255, 255, 255, 255),
        margin: EdgeInsets.only(right: 20),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            SizedBox(
              height: 10,
            ),
            Text(
              'Bs ' + subtitle,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      );
    }

    return Container(
      color: Color.fromARGB(255, 237, 237, 237),
      child: FutureBuilder(
        future: projectManaPageAdminProvider.read.getSubscriptionProjectMana(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: CustomTitle2(
                    title: 'Hola!',
                    subTitle: 'Bienvenid@ al panel de administración',
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        card('TOTAL ACUMULADO', '123123'),
                        card('TOTAL INSCRITOS', '12'),
                        card('TOTAL ACUMULADO', '123123'),
                        card('TOTAL ACUMULADO', '123123'),
                        card('TOTAL ACUMULADO', '123123'),
                        card('TOTAL ACUMULADO', '123123'),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),

                  padding: EdgeInsets.all(20),
                  //color: Colors.white,
                  child: Column(
                    children: [
                      CustomTitle2(
                          title: 'Lista de Inscritos al Proyecto Maná'),
                      Consumer(builder: (_, ref, __) {
                        final List<SubscriptionProjectMana>? listSignUpData =
                            ref.select(projectManaPageAdminProvider
                                .select((p0) => p0.listBrochureSubscription));
                        return DataTable2(
                            headingRowColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 243, 244, 245),
                            ),
                            headingTextStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                            dataRowHeight: 65,

                            // smRatio: 10,
                            lmRatio: 2.0,
                            smRatio: 0.5,
                            minWidth: width * 1.6,
                            columns: [
                              DataColumn2(
                                label: Text('NOMBRE'),
                                size: ColumnSize.L,
                              ),
                              DataColumn2(
                                  label: Text('FOLLETO'), size: ColumnSize.M),
                              DataColumn2(
                                  label: Text('Cancelado'), size: ColumnSize.M),
                              DataColumn2(
                                  label: Text('Cuotas'), size: ColumnSize.M),
                            ],
                            rows: _createRows(listSignUpData!));
                      }),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return WillPopScope(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Color.fromARGB(255, 255, 255, 255),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
                onWillPop: () async => false);
          }
        },
      ),
    );
  }

  List<DataRow> _createRows(List<SubscriptionProjectMana> list) {
    return list.map((SubscriptionProjectMana subscriptionProjectMana) {
      SignUpData? user = subscriptionProjectMana.signUpData;
      Brochure? brochure = subscriptionProjectMana.brochure;
      BrochureSubscription? brochureSubscription =
          subscriptionProjectMana.brochureSubscription;

      String? nameBrochure = brochure?.spanish;
      String? canceledAmount = brochureSubscription?.canceledAmount;
      //log(nameBrochure!);
      int? canceledCount =
          brochureSubscription?.listCanceledAmountHistory!.length;

      return DataRow(cells: [
        DataCell(ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(subscriptionProjectMana.signUpData!.name),
          subtitle: Text(subscriptionProjectMana.signUpData!.email),
        )),
        DataCell(Text(nameBrochure ?? 'No tiene Folleto')),
        DataCell(Text(
          canceledAmount ?? '0',
        )),
        DataCell(Text(canceledCount == null ? '0' : canceledCount.toString())),
      ]);
    }).toList();
  }
}
/**DataTable2(
                columnSpacing: 20,
                horizontalMargin: 15,
                dataRowHeight: 65,
                // smRatio: 10,
                lmRatio: 3.5,
                smRatio: 0.5,
                minWidth: width * 1.6,
                columns: [
                  DataColumn2(
                    label: Text('Name'),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(label: Text('Column B'), size: ColumnSize.M),
                  DataColumn2(label: Text('Column B'), size: ColumnSize.M),
                  DataColumn2(label: Text('Column D'), size: ColumnSize.M),
                  DataColumn2(
                    label: Text('Column NUMBERS'),
                    numeric: true,
                  ),
                ],
                rows: _createRows()
              ); */