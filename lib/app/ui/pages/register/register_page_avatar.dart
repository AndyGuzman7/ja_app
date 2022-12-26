import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/userAvatar.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_button.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/pages/register/register_page.dart';
import 'package:ja_app/app/utils/MyColors.dart';

class RegisterPageAvatar extends StatelessWidget {
  const RegisterPageAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    registerProvider.read.getAvatar();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const CustomTitle2(
              title: "Selecciona tu avatar",
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer(builder: (_, ref, __) {
              List<UserAvatar> list =
                  ref.select(registerProvider.select((_) => _.listAvatar!));

              return Flexible(
                flex: 3,
                child: GridView.count(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: 4,
                  children: buildPhotoItem(list),
                ),
              );
            }),
            CustomButton(
              textButton: 'Siguiente',
              onPressed: () => registerProvider.read.nextPage(),
            )
          ],
        ),
      ),
    );
  }

  void selectUserAvatar(UserAvatar i, List<UserAvatar> list) {
    List<UserAvatar> listNew = [];
    for (var e in list) {
      if (e.isSelect == true && e.name != i.name) {
        e.isSelect = false;
      }

      if (e.name == i.name) {
        e.isSelect = true;
        log("message");
      }
      UserAvatar f = UserAvatar(e.name, e.url, e.isSelect);
      log(f.isSelect.toString() + " " + f.name);

      listNew.add(f);
    }
    registerProvider.read.onUserAvatarChanged(i);
    registerProvider.read.onListAvatarChanged(listNew);
  }

  List<Widget> buildPhotoItem(List<UserAvatar> list) {
    List<Widget> lisWidgets = [];
    for (UserAvatar item in list) {
      lisWidgets.add(
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.network(item.url).image,
              opacity: item.isSelect ? 0.2 : 1,
              fit: BoxFit.cover,
            ),
          ),
          child: InkWell(
            onTap: () => selectUserAvatar(item, list),
            child: Expanded(
              child: Ink(
                height: 100,
                width: 100,
                child: Align(
                  alignment: Alignment.center,
                  child: item.isSelect
                      ? Icon(
                          Icons.check,
                          size: 50,
                          color: CustomColorPrimary().materialColor,
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return lisWidgets;
  }
}
