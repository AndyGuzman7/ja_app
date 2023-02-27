import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';

import '../../../utils/MyColors.dart';

class AtributeDataV1 extends StatelessWidget {
  final String text1, text2;
  const AtributeDataV1(this.text1, this.text2, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      color: Color.fromARGB(255, 246, 245, 245),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
                child: CustomTitle2(
              title: text1,
              fontSize: 16,
            )),
            Expanded(
                child: CustomTitle2(
              title: text2,
              fontSize: 16,
              isBoldTitle: true,
              textAlignTitle: TextAlign.right,
            )),
          ],
        ),
      ),
    );
  }
}

class AtributeDataV2 extends StatelessWidget {
  final String text1, text2;
  const AtributeDataV2(this.text1, this.text2, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      color: Color.fromARGB(255, 246, 245, 245),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTitle2(
              title: text1,
              fontSize: 16,
            ),
            CustomTitle2(
              title: text2,
              fontSize: 16,
              isBoldTitle: true,
              textAlignTitle: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}

class AtributeDataV3 extends StatelessWidget {
  final String text1, text2;
  const AtributeDataV3(this.text1, this.text2, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 5),
      color: Color.fromARGB(255, 246, 245, 245),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Expanded(
              child: Container(
            height: 60,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 10, right: 10),
            color: CustomColorPrimary().materialColor,
            child: CustomTitle2(
              title: text1,
              colorTitle: Colors.white,
              fontSize: 12,
            ),
          )),
          Container(
            width: 70,
            height: 60,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: CustomTitle2(
              title: text2,
              fontSize: 12,
              isBoldTitle: true,
              textAlignTitle: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
