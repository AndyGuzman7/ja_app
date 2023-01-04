import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/data/repositories/user_impl/login_impl/authentication_repository.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_button.dart';
import 'package:ja_app/app/ui/gobal_widgets/side_menu/side_menu.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/pages/home/controller/home_controller.dart';
import 'package:ja_app/app/ui/pages/home/home_page.dart';
import 'package:ja_app/app/ui/pages/home/widgets/item_button.dart';
import 'package:ja_app/app/ui/routes/routes.dart';
import 'package:ja_app/app/utils/MyColors.dart';

import '../controller/home_state.dart';

class MainPageHome extends StatelessWidget {
  final StateProvider<HomeController, HomeState> provider;
  const MainPageHome({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer(
          builder: (_, watch, __) {
            final user = watch.select(provider.select((p0) => p0.user));

            return Container(
              margin: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/ja-app-6430b.appspot.com/o/images-resources%2FlogoJA3.png?alt=media&token=e3eb6050-1f41-4260-a468-073116f2c10b"),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  //https://firebasestorage.googleapis.com/v0/b/ja-app-6430b.appspot.com/o/images-resources%2FlogoJA3.png?alt=media&token=e3eb6050-1f41-4260-a468-073116f2c10b
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 102, 134, 230),
                      Color.fromARGB(229, 102, 134, 230),
                      Color.fromARGB(255, 127, 159, 229).withOpacity(0.5),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Bienvenid" +
                                  (user!.gender == "0" ? "o" : "a") +
                                  " ${user.name}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            subtitle: const Text(
                              "Que Dios te bendiga",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    CustomButton(
                      width: 100,
                      colorTextButton:
                          CustomColorPrimary().materialColor.shade100,
                      onPressed: (() {}),
                      colorButton: Colors.white,
                      textButton: "Mi perfil",
                      height: 20,
                    )
                  ],
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Tus funciones",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.phone_iphone_outlined,
                color: CustomColorPrimary().materialColor.shade100,
              )
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: GridView.count(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            crossAxisCount: 2,
            children:
                getItemButtons(searchPermisson(provider.read.state.user!)),
          ),
        ),
      ],
    );
  }

  List<Widget> getItemButtons(String permisonType) {
    List<Widget> list = [];
    switch (permisonType) {
      case "A":
        list = [
          const ItemButton(
            textTitle: "Miembros",
            pageRoute: Routes.LIST_ESTUDENTS,
            textSubTitle: '5 registrados',
            iconButtonItem: Icon(Icons.supervised_user_circle),
          ),
          const ItemButton(
            textTitle: "EESS",
            pageRoute: Routes.EESS,
            textSubTitle: 'Escuela sábatica',
            iconButtonItem: Icon(
              Icons.school,
              color: Colors.blue,
            ),
          ),
          const ItemButton(
            textTitle: "Noticias",
            pageRoute: Routes.LIST_ESTUDENTS,
            textSubTitle: '5 registrados',
            iconButtonItem: Icon(Icons.supervised_user_circle),
          ),
          const ItemButton(
            textTitle: "Calendario",
            pageRoute: Routes.EESS,
            textSubTitle: 'Escuela sábatica',
            iconButtonItem: Icon(
              Icons.school,
              color: Colors.blue,
            ),
          )
        ];
        break;

      case "C":
        list = [
          const ItemButton(
            textTitle: "Noticias",
            pageRoute: Routes.LIST_ESTUDENTS,
            textSubTitle: '5 registrados',
            iconButtonItem: Icon(Icons.supervised_user_circle),
          ),
          const ItemButton(
            textTitle: "Calendario",
            pageRoute: Routes.EESS,
            textSubTitle: 'Escuela sábatica',
            iconButtonItem: Icon(
              Icons.school,
              color: Colors.blue,
            ),
          )
        ];
        break;

      default:
    }

    return list;
  }

  String searchPermisson(UserData signUpData) {
    String permissonType = signUpData.listPermisson.contains("A") ? "A" : "F";

    permissonType =
        signUpData.listPermisson.contains("B") ? "B" : permissonType;
    permissonType =
        signUpData.listPermisson.contains("C") ? "C" : permissonType;

    return permissonType;
  }
}

class SideMenu extends StatelessWidget {
  late Timer timer;
  String? username;
  SideMenu({this.username});
  Color colorMain = Color.fromRGBO(255, 193, 7, 1);
  @override
  Widget build(BuildContext context) {
    SideMenuFunctionality functionality = SideMenuFunctionality(context);
    var divider = Divider(
      color: Colors.grey[350],
      height: 5,
      thickness: 1.5,
      indent: 10,
      endIndent: 10,
    );
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: colorMain,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                          'https://www.hispano-irish.com/wp-content/uploads/2020/05/PngItem_1300253.png'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(this.username ?? "Nombre usuario"),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            divider,
            ListTile(
              onTap: () {
                //functionality.onPressedbtnContactEmergency();
              },
              leading: Icon(Icons.contact_page_rounded),
              title: Text('Contactos de Emergencia'),
            ),
            divider,
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'listContact');
              },
              leading: Icon(Icons.location_on),
              title: Text('Compartir Ubicacion'),
            ),
            GestureDetector(
              onPanCancel: () => timer.cancel(),
              onPanDown: (_) => {
                timer = Timer(Duration(seconds: 5), () async {
                  //functionality.onPressedbtnCallPanic();
                })
              },
              child: ListTile(
                tileColor: Colors.red.shade100,
                leading: Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
                ),
                onTap: () {
                  // functionality.onPressedTimePressedFault();
                },
                title: Text(
                  'Boton de Panico',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            divider,
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: Text(
                'Cerrar Sesion',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                //functionality.onPressedLogOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SideMenuFunctionality {
  BuildContext context;
  SideMenuFunctionality(this.context);

  AlertDialog alertDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amber.shade50,
      title: new Text("ALERTA PANICO!!"),
      content: new Text("Mesaje de Alerta Enviado Con Exito."),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FloatingActionButton(
          backgroundColor: Colors.amberAccent,
          child: new Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
