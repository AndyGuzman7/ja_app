import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/country.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/ui/gobal_widgets/drop_dow/custom_dropDown.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_button.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_input_field.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_paragraph.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/pages/eess/eess_page.dart';
import 'package:ja_app/app/utils/MyColors.dart';

import '../../../../domain/models/church/church.dart';
import '../controller/eess_controller.dart';
import '../controller/eess_state.dart';

class MainPageEess extends StatelessWidget {
  final StateProvider<EeSsController, EeSsState> provider;
  const MainPageEess({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, watch, __) {
      final eess = watch.select(
        eeSsProvider.select((state) => state.eess),
      );

      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.black,
                child: Image.network(
                  eess!.photoURL!,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.book,
                    size: 17,
                    color: CustomColorPrimary().materialColor.shade100,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  /* Text(
                              "Región " + eess.region.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),*/
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "(EESS)",
                    style: TextStyle(color: Color.fromARGB(255, 109, 109, 109)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Escuela Sábatica Adventista",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    eess.name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Clase de EESS",
                    style: TextStyle(color: Color.fromARGB(255, 109, 109, 109)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider()
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                //margin: EdgeInsets.all(15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  //color: CustomColorPrimary().materialColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: double.infinity,
                        //margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          color: CustomColorPrimary().materialColor,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_box_outlined,
                              size: 17,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Usted es un miembro de esta clase EESS",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )),
                    CustomTitle2(
                      fontSize: 15,
                      title: "Información",
                      isBoldTitle: true,
                      colorTitle: Colors.black,
                    ),
                    CustomParagraph(
                      paragraph: eess.information! == ''
                          ? "Aun no hay Información"
                          : eess.information!,
                      colorText: Color.fromARGB(255, 77, 77, 77),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
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
