import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ja_app/pages/photoUpload.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Homef"),
        ),
        body: Container(),
        bottomNavigationBar: BottomAppBar(
          color: Colors.blueAccent,
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PhotoUpload();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.add_a_photo),
                iconSize: 40,
                color: Colors.white,
              )
            ],
          )),
        ));
  }
}
