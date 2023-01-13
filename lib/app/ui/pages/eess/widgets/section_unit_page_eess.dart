import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_input_field.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/pages/eess/eess_page.dart';
import 'package:ja_app/app/ui/pages/studentes_list/widgets/item_member.dart';
import 'package:ja_app/app/utils/MyColors.dart';

class SectionUnitPageEESS extends StatelessWidget {
  final UnitOfAction unitOfAction;
  const SectionUnitPageEESS({Key? key, required this.unitOfAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomTitle2(title: unitOfAction.name),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomTitle2(title: "Miembros"),
              ),
            ),
          ]),
        ),
        FutureBuilder(
            future: eeSsProvider.read.getMembersToUnitOfAction(unitOfAction.id),
            builder: (context, AsyncSnapshot<List<UserData>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Container(
                    child: Text("No hay miembros"),
                  );
                } else {
                  return Container(
                    height: 200,
                    color: Colors.grey.shade100,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      //padding: const EdgeInsets.only(top: 20),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        log("otra veeee");
                        return ItemMemberV2(snapshot.data![index]);
                      },
                    ),
                  );
                }
              } else {
                return Container(height: 200, child: willPopScope());
              }
            }),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomTitle2(title: "Metas"),
              ),
            ),
          ]),
        ),
        subTitle('Comunión'),
        cardTerm(
            "N° de miembros con suscripción a la lección de Escuela Sabática",
            "0"),
        SizedBox(
          height: 10,
        ),
        cardTerm("N° de miembros que estudian la lección diariamente", "0"),
        subTitle('Relacionamiento'),
        cardTerm("N° de miembros que participan de un GP", "0"),
        SizedBox(
          height: 10,
        ),
        cardTerm("N° de miembros que participan de una Unidad de acción", "0"),
        subTitle('Misión'),
        cardTerm("N° de parejas misioneras en la Unidad de Acción", "0"),
        SizedBox(
          height: 10,
        ),
      ],
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

  Widget subTitle(title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Icon(Icons.keyboard_arrow_right_outlined),
        Expanded(
          child: CustomTitle3(title: title),
        ),
      ]),
    );
  }

  Widget cardTerm(title, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        //width: 50,
        //color: CustomColorPrimary().materialColor,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustomColorPrimary().materialColor,
        ),
        child: InkWell(
          onTap: (() {
            //eeSsProvider.read.onChangedUnitOfAction(object);
          }),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Text(value),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
