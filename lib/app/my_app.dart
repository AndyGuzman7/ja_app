import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ja_app/app/ui/routes/app_routes.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Blog App",
      theme: ThemeData(
        textTheme: GoogleFonts.mitrTextTheme(
          const TextTheme(
            bodyText1: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        primaryColor: Colors.blueAccent,
      ),
      initialRoute: Routes.SPLASH,
      routes: appRoutes,
      navigatorObservers: [router.observer],
      debugShowCheckedModeBanner: false,
      //home: HomePage(),
    );
  }
}
