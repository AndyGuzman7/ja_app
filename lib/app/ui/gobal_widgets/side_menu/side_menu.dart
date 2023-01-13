import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/side_menu/controller/side_menu_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/side_menu/controller/side_menu_state.dart';
import 'package:ja_app/app/ui/routes/routes.dart';
import 'package:ja_app/app/utils/MyColors.dart';

final sideMenuProvider = StateProvider<SideMenuController, SideMenuState>(
    (_) => SideMenuController(sessionProvider.read),
    autoDispose: true);

class NavigatorDrawer extends StatelessWidget {
  const NavigatorDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("si se inicia");
    return SizedBox(
      width: MediaQuery.of(context).size.width *
          0.80, // 75% of screen will be occupied

      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        child: Drawer(
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                builderHeader(context),
                builderMenuItems(context),
                builderBottonItems(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  builderBottonItems(context) {
    return Column(
      children: [
        itemButton(
          'Logout',
          () async {
            await sessionProvider.read.signOut();
            router.pushNamedAndRemoveUntil(Routes.LOGIN);
          },
          icon: Icon(Icons.logout_outlined),
          color: const Color.fromARGB(255, 117, 117, 117),
        )
      ],
    );
  }

  itemButton(text, onTap,
      {Icon? icon, Color color = const Color.fromARGB(255, 63, 62, 62)}) {
    /*icon = Icon(
      icon!.icon,
      color: color,
    );*/
    return ListTile(
      style: ListTileStyle.drawer,
      leading: icon,
      title: Text(
        text,
        style: TextStyle(fontSize: 16, color: color),
      ),
      onTap: onTap,
    );
  }

  itemButtonChilds(text, List<Widget> children, Icon icon,
      {Color color = const Color.fromARGB(255, 63, 62, 62)}) {
    icon = Icon(
      icon.icon,
      color: color,
    );

    return ExpansionTile(
        leading: icon,
        title: Text(
          text,
          style: TextStyle(fontSize: 16, color: color),
        ),
        children: children);
  }

  itemChild(text, onTap) {
    return ListTile(
      //style: ListTileStyle.drawer,
      leading: Padding(
        padding: EdgeInsets.only(left: 50),
        child: Container(child: Text('-')),
      ),
      title: Text(
        text,
        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 59, 59, 59)),
        textAlign: TextAlign.start,
      ),
      onTap: onTap,
    );
  }

  builderHeader(BuildContext context) {
    return Consumer(builder: (_, watch, __) {
      final user = watch.watch(sessionProvider).userData!;
      return DrawerHeader(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            children: [
              Container(
                child: Image.network(user.photoURL),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColorPrimary().materialColor,
                ),
                width: 50,
                height: 50,
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    user.name,
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    user.email,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  builderMenuItems(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: 16,
          children: [
            itemButton(
              'Profile',
              () {},
              icon: Icon(Icons.person_outline_rounded),
            ),
            itemButtonChilds(
              'Mi iglesia',
              [
                itemChild(
                  'Iglesia',
                  () {
                    router.pushNamed(Routes.CHURCH);
                  },
                ),
                itemChild(
                  'Escuela sábatica',
                  () {
                    router.pushNamed(Routes.EESS);
                  },
                ),
              ],
              const Icon(Icons.other_houses_outlined),
            ),
            const Text('Actividades'),
            itemButtonChilds(
              'Proyectos',
              [
                itemChild(
                  'Proyecto Maná',
                  () {
                    router.pushNamed(Routes.PROJECTS);
                  },
                ),
              ],
              const Icon(Icons.spoke_outlined),
            ),
            itemButton(
              'Eventos',
              () {},
              icon: Icon(Icons.event_outlined),
            ),
            Divider(),
            itemButton(
              'Recursos',
              () {},
              icon: Icon(Icons.folder_outlined),
            ),
            itemButton(
              'Configuración',
              () {},
              icon: Icon(Icons.settings_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
