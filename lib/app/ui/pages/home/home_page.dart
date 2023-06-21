import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/side_menu/side_menu.dart';
import 'package:ja_app/app/ui/pages/home/controller/home_controller.dart';
import 'package:ja_app/app/ui/pages/home/controller/home_state.dart';
import 'package:ja_app/app/ui/pages/home/widgets/calendar_page_home.dart';
import 'package:ja_app/app/ui/pages/home/widgets/main_page_home.dart';
import 'package:ja_app/app/ui/pages/home/widgets/noticies_page_home.dart';
import 'package:ja_app/app/utils/MyColors.dart';

final homeProvider = StateProvider<HomeController, HomeState>(
    (_) => HomeController(sessionProvider.read));

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
//int currentTab = 0;
  final List<Widget> listWidgets = [
    MainPageHome(
      provider: homeProvider,
    ),
    NoticiesPageHome(),
    CalendarPageHome()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = MainPageHome(
    provider: homeProvider,
  );
  @override
  Widget build(BuildContext context) {
    PopupMenuItem _buildPopupMenuItem(String title) {
      return PopupMenuItem(
        child: Text(title),
      );
    }

    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 253, 254, 255),
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder(
          future: homeProvider.read.getUser(),
          builder: (context, AsyncSnapshot<UserData?> snapshot) {
            if (snapshot.hasData) {
              homeProvider.read.onChangedUser(snapshot.data!);
              return Scaffold(
                drawer: NavigatorDrawer(),
                appBar: AppBar(
                  actions: [
                    PopupMenuButton(
                      itemBuilder: (ctx) => [
                        _buildPopupMenuItem('Search'),
                        _buildPopupMenuItem('Upload'),
                        _buildPopupMenuItem('Copy'),
                        _buildPopupMenuItem('Exit'),
                      ],
                    )
                  ],
                  iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
                  title: Consumer(builder: (_, watch, __) {
                    final s = watch.select(
                      homeProvider.select((state) => state.title),
                    );
                    return Text(
                      s,
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    );
                  }),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: Consumer(builder: (_, watch, __) {
                  final s = watch.select(
                    homeProvider.select((state) => state.currentTab),
                  );
                  return PageStorage(
                    bucket: bucket,
                    child: currentScreen,
                  );
                }),
                /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
                bottomNavigationBar: BottomAppBar(
                  child: Consumer(builder: (_, watch, __) {
                    final s = watch.select(
                      homeProvider.select((state) => state.currentTab),
                    );
                    return Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              currentScreen = MainPageHome(
                                provider: homeProvider,
                              );
                              homeProvider.read.onChangedCurrentTab(0);
                              homeProvider.read.onChangedTitle("Inicio");
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.home,
                                  color: s == 0
                                      ? CustomColorPrimary().materialColor
                                      : Colors.grey,
                                ),
                                Text(
                                  "Inicio",
                                  style: TextStyle(
                                      color: s == 0
                                          ? CustomColorPrimary().materialColor
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              currentScreen = CalendarPageHome();
                              homeProvider.read.onChangedCurrentTab(1);
                              homeProvider.read.onChangedTitle("Calendario");
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: s == 1
                                      ? CustomColorPrimary().materialColor
                                      : Colors.grey,
                                ),
                                Text(
                                  "Calendario",
                                  style: TextStyle(
                                      color: s == 1
                                          ? CustomColorPrimary().materialColor
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              currentScreen = NoticiesPageHome();
                              homeProvider.read.onChangedCurrentTab(2);
                              homeProvider.read.onChangedTitle("Noticias");
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.notifications_none,
                                  color: s == 2
                                      ? CustomColorPrimary().materialColor
                                      : Colors.grey,
                                ),
                                Text(
                                  "Noticias",
                                  style: TextStyle(
                                      color: s == 2
                                          ? CustomColorPrimary().materialColor
                                          : Colors.grey),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                  notchMargin: 10,
                  shape: CircularNotchedRectangle(),
                ),
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
    );
  }
}
