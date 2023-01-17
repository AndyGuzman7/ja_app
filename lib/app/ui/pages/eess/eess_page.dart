import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/pages/eess/controller/eess_controller.dart';
import 'package:ja_app/app/ui/pages/eess/controller/eess_state.dart';

final eeSsProvider = StateProvider<EeSsController, EeSsState>(
    (_) => EeSsController(sessionProvider.read),
    autoDispose: true);

class EeSsPage extends StatelessWidget {
  EeSsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("se imprime el padre");
    return Container(
      child: DefaultTabController(
        length: eeSsProvider.read.state.listTabr.length,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.blueGrey[50],
          appBar: AppBar(
            title: new Text("Escuela Sábatica"),
            bottom: TabBar(
              tabs: eeSsProvider.read.state.listTabr,
            ),
          ),
          body: TabBarView(children: eeSsProvider.read.state.listTabBarView),
        ),
      ),
    );
  }
}
