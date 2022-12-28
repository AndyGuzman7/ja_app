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

import 'controller/register_controller.dart';
import 'controller/register_state.dart';

class RegisterPageAvatar extends StatefulWidget {
  StateProvider<RegisterController, RegisterState> providerListener;
  RegisterPageAvatar({
    Key? key,
    required this.providerListener,
  }) : super(key: key);

  @override
  State<RegisterPageAvatar> createState() => _RegisterPageAvatarState();
}

class _RegisterPageAvatarState extends State<RegisterPageAvatar>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    log("nuevamente");
    widget.providerListener.read.getAvatar();
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          const CustomTitle2(
            title: "Hola, Bienvenido",
            subTitle: "Selecciona un avatar para tu perfil",
            colorSubTitle: Color.fromARGB(255, 117, 117, 117),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Consumer(builder: (_, ref, __) {
              List<UserAvatar> list = ref
                  .select(widget.providerListener.select((_) => _.listAvatar!));

              return GridView.count(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                crossAxisCount: 4,
                children: buildPhotoItem(list),
              );
            }),
          ),
          CustomButton(
            height: 48,
            textButton: 'Siguiente',
            onPressed: () => widget.providerListener.read.nextPage(context),
          )
        ],
      ),
    );
  }

/**
 * 
 * 
 * Column(
      children: <Widget>[
        CardScrollWidget(currentPage),
        Positioned.fill(
          child: PageView.builder(
            itemCount: images.length,
            controller: controller,
            reverse: true,
            itemBuilder: (context, index) {
              return Container();
            },
          ),
        )
      ],
    );
 * 
 * 
 */
  void selectUserAvatar(UserAvatar i, List<UserAvatar> list) {
    List<UserAvatar> listNew = [];
    for (var e in list) {
      if (e.isSelect == true && e.name != i.name) {
        e.isSelect = false;
      }
      if (e.name == i.name) {
        e.isSelect = true;
      }
      UserAvatar f = UserAvatar(e.name, e.url, e.isSelect);
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
            child: Align(
              alignment: Alignment.center,
              child: item.isSelect
                  ? Icon(
                      Icons.check_circle_outline,
                      size: 40,
                      color: CustomColorPrimary().materialColor,
                    )
                  : null,
            ),
          ),
        ),
      );
    }
    return lisWidgets;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
