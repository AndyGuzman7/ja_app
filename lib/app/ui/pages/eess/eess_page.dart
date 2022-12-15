import 'package:flutter/material.dart';

class EeSsPage extends StatelessWidget {
  const EeSsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.blueGrey[50],
          appBar: AppBar(
            title: new Text("Escuela Sábatica"),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: ("Miembros"),
                ),
                Tab(
                  text: ("Tarjeta"),
                ),
                Tab(
                  text: ("Otros"),
                )
              ],
            ),
          ),
          body: TabBarView(children: [
            Center(
                child: Text(
              "One",
              style: TextStyle(fontSize: 50),
            )),
            Center(
                child: Text(
              "Two",
              style: TextStyle(fontSize: 50),
            )),
            Center(
                child: Text(
              "Three",
              style: TextStyle(fontSize: 50),
            ))
          ]),
        ),
      ),
    );
  }
}
