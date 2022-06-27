import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentsListPage extends StatelessWidget {
  const StudentsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [],
          ),
        ),
      ),
    );
  }
}
