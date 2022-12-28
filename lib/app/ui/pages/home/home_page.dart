import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/data/repositories/user_impl/login_impl/authentication_repository.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/side_menu/side_menu.dart';
import 'package:ja_app/app/ui/pages/home/controller/home_controller.dart';
import 'package:ja_app/app/ui/pages/home/widgets/item_button.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

final homeProvider = SimpleProvider(
  (_) => HomeController(sessionProvider.read),
);

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*ProviderListener<HomeController>(provider: homeProvider, builder: (_, controller){
      return
    })*/

    List<Widget> listWidgets = [];
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          color: const Color.fromARGB(255, 253, 254, 255),
          width: double.infinity,
          height: double.infinity,
          child: FutureBuilder(
            future: homeProvider.read.getUser(),
            builder: (context, AsyncSnapshot<UserData?> snapshot) {
              log(snapshot.hasData.toString());
              if (snapshot.hasData) {
                log(snapshot.data!.listPermisson.first);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Consumer(
                      builder: (_, watch, __) {
                        final user = snapshot.data;
                        return Container(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 102, 133, 230),
                                Color.fromARGB(255, 127, 159, 229)
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  "Bienvenido ${user!.name}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: const Text(
                                  "Que Dios te bendiga",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              CupertinoButton(
                                  color: Colors.white,
                                  child: const Text(
                                    "View perfil",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 13, 43, 68)),
                                  ),
                                  onPressed: () {})
                            ],
                          ),
                        );
                      },
                    ),
                    Flexible(
                      flex: 2,
                      child: GridView.count(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        crossAxisCount: 2,
                        children:
                            getItemButtons(searchPermisson(snapshot.data!)),
                      ),
                    ),
                    const Text("Home page"),
                    CupertinoButton(
                      child: const Text("Sign out"),
                      onPressed: () async {
                        await sessionProvider.read.signOut();
                        router.pushNamedAndRemoveUntil(Routes.LOGIN);
                      },
                      color: Colors.blue,
                    )
                  ],
                );
              } else {
                return WillPopScope(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                    onWillPop: () async => false);
              }
            },
          ),
        ),
      ),
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
        signUpData.listPermisson.contains("c") ? "B" : permissonType;

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
