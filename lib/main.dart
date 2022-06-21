import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homePage.dart';

void main() {
  runApp(const BlogApp());
}

class BlogApp extends StatelessWidget {
  const BlogApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: "Blog App",
      theme: ThemeData(
        textTheme: GoogleFonts.mitrTextTheme(
            TextTheme(bodyText1: TextStyle(fontWeight: FontWeight.bold))),
        primaryColor: Colors.blueAccent,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
