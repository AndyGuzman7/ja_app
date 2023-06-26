import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/eess/quarter.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_input_field.dart';
import 'package:ja_app/app/ui/gobal_widgets/load/load.dart';
import 'package:ja_app/app/ui/pages/sabbatical_school/widgets/widget_date.dart';

import '../../../../domain/models/target_virtual/target_virtual.dart';
import '../../../../utils/MyColors.dart';
import '../../../../utils/date_controller.dart';
import '../../../gobal_widgets/atribute_data/atribute_data.dart';
import '../../../gobal_widgets/inputs/custom_button.dart';
import '../../../gobal_widgets/row/row_custom.dart';
import '../../../gobal_widgets/text/custom_title.dart';
import '../controller/target_page_controller/target_page_controller.dart';
import '../controller/target_page_controller/target_page_state.dart';

class WidgetOffering extends StatelessWidget {
  Quarter quarter;
  //StateProvider<TargetPageController, TargetPageState> targetPageProviders;
  WidgetOffering(this.quarter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        leading: null,
        title: Text(
          "Ofrenda",
          style: TextStyle(fontSize: 20, color: null),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(child: Text(quarter.name)),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Consumer(builder: (context, ref, child) {
            final response = ref.watch(
              targetPageProvider.select((state) => state),
            );
            var targetVirtual = response.state.targetVirtualSelected;
            return Padding(
              padding: const EdgeInsets.all(15),
              child: RowCustomTree(
                  AtributeDataV3("BLANCO\nSEMANAL",
                      targetVirtual!.whiteTSOffering.toString() + " Bs"),
                  AtributeDataV3(
                      "BLANCO 13°\nSÁBADO",
                      targetVirtual.whiteWeeklyOffering.toString().toString() +
                          " Bs"),
                  CustomButton(
                    icon: Icon(
                      Icons.edit,
                      color: CustomColorPrimary().materialColor,
                      size: 25,
                    ),
                    colorBorderButton: CustomColorPrimary().materialColor,
                    width: 60,
                    height: 60,
                    colorButton: Colors.white,
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return contentDialogShowOfferting(context);
                        },
                      );
                    },
                  )),
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              children: [
                Expanded(
                    child:
                        Text("Para registrar una ofrenda mantenga presionado")),
              ],
            ),
          ),
          FutureBuilder(
            future:
                targetPageProvider.read.loadDataUnitOfferingSection(context),
            builder: (context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer(builder: (context, ref, child) {
                  final response = ref.select(
                    targetPageProvider.select((state) => state.listDayOffering),
                  );

                  if (response.isEmpty) {
                    return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text("No hay registros"),
                            ],
                          ),
                        ));
                  } else {
                    return SizedBox(
                      height: 290,
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        crossAxisCount: 4,
                        children: itemsOffering(response, context),
                      ),
                    );
                  }
                });
              }

              return const SizedBox(height: 200, child: Load());
            },
          ),
        ]);
  }

  contentSectionOfferting(BuildContext context, DayOffering dayOffering) {
    return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 15,
            left: 15,
            right: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTitle(
              title: "Registro de Ofrenda",
              subTitle: "Registre el valor de la ofrenda del sábado",
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(255, 240, 240, 240)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Fecha:"),
                    CardDate(date: dayOffering.date),
                    Consumer(builder: (context, ref, child) {
                      final response = ref.select(
                        targetPageProvider
                            .select((state) => state.dateTimeSelected),
                      );

                      return CustomButton(
                          textButton: "Guardar",
                          width: 100,
                          height: 48,
                          onPressed: DateController()
                                  .compareTwoDates(response!, DateTime.now())
                              ? () async {
                                  await targetPageProvider.read
                                      .onPressedBtnRegisterOffering(context);
                                }
                              : null);
                    })
                  ]),
            ),
            Form(
              key: targetPageProvider.read.formKeyOffering,
              child: CustomInputField(
                initialValue:
                    targetPageProvider.read.state.quantitiy.toString(),
                inputType: TextInputType.number,
                onChanged: (s) {
                  if (s != "" && s != ".") {
                    targetPageProvider.read.onChangedQuantity(double.parse(s));
                  }
                },
                icon: const Icon(Icons.attach_money_outlined),
                label: "monto/valor de la ofrenda (ejemplo 30.4)",
                validator: (text) {
                  if (text == "") return "Es necesario un monto";
                  text = text!.replaceAll(" ", "");
                  //return isValidPhone(text) ? null : "Celular Invalido";
                },
              ),
            ),
          ],
        ));
  }

  List<Widget> itemsOffering(
      List<DayOffering> listDayOffering, BuildContext context) {
    Widget item2(isSelect, DayOffering dayOffering) {
      return Card(
        margin: EdgeInsets.only(top: 1, bottom: 1),
        color: Color.fromARGB(255, 255, 255, 255),
        elevation: 1,
        child: InkWell(
          onLongPress: () {
            targetPageProvider.read.onChangedOffering(dayOffering);
            targetPageProvider.read.onChangedQuantity(dayOffering.quatity);

            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return contentSectionOfferting(context, dayOffering);
                });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayOffering.day.toString() + "°",
                  style: TextStyle(fontSize: 14),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      dayOffering.quatity.toString() + " Bs",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 123, 123, 123)),
                    )),
                Text(
                  dayOffering.date.day.toString() +
                      "/" +
                      dayOffering.date.month.toString() +
                      "/" +
                      dayOffering.date.year.toString(),
                  style: TextStyle(color: Color.fromARGB(255, 13, 97, 167)),
                )
              ],
            ),
          ),
        ),
      );
    }

    return listDayOffering.map((e) => item2(false, e)).toList();
  }

  contentDialogShowOfferting(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 15,
            left: 15,
            right: 15),
        child: Form(
          key: targetPageProvider.read.formKeyOfferingWhites,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTitle(
                title: "Ofrenda Misionera",
                subTitle: "Registre el valor del blanco",
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(255, 240, 240, 240)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(""),
                      Text("Blanco trimestral"),
                      Consumer(builder: (context, ref, child) {
                        final response = ref.select(
                          targetPageProvider
                              .select((state) => state.dateTimeSelected),
                        );

                        return CustomButton(
                            textButton: "Guardar",
                            width: 100,
                            height: 48,
                            onPressed: () async {
                              await targetPageProvider.read
                                  .onPressedBtnRegisterWhites(context);
                            });
                      })
                    ]),
              ),
              CustomInputField(
                inputType: TextInputType.number,
                onChanged: (s) {
                  if (s != "" && s != ".") {
                    targetPageProvider.read.onChangedOnWhite1(double.parse(s));
                  }
                },
                initialValue: targetPageProvider.read.state.white1.toString(),
                icon: const Icon(Icons.attach_money_outlined),
                label: "Blanco Semanal (ejemplo 30.4)",
                validator: (text) {
                  if (text == "") return "Es necesario un monto";
                  text = text!.replaceAll(" ", "");
                  //return isValidPhone(text) ? null : "Celular Invalido";
                },
              ),
              CustomInputField(
                inputType: TextInputType.number,
                onChanged: (s) {
                  if (s != "" && s != ".") {
                    targetPageProvider.read.onChangedWhite2(double.parse(s));
                  }
                },
                initialValue: targetPageProvider.read.state.white2.toString(),
                icon: const Icon(Icons.attach_money_outlined),
                label: "Blanco 13° Sábado (ejemplo 30.4)",
                validator: (text) {
                  if (text == "") return "Es necesario un monto";
                  text = text!.replaceAll(" ", "");
                  //return isValidPhone(text) ? null : "Celular Invalido";
                },
              ),
            ],
          ),
        ));
  }
}
