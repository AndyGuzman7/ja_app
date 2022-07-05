import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ja_app/app/ui/routes/app_routes.dart';
import 'package:ja_app/app/ui/routes/routes.dart';
import 'package:ja_app/app/utils/MyColors.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Blog App",
      theme: ThemeData(
        //brightness: Brightness.light,
        primaryColor: Colors.amber,
        textTheme: GoogleFonts.mitrTextTheme(
          const TextTheme(
            bodyText1: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        primarySwatch: CustomColorPrimary().materialColor,
      ),
      navigatorKey: router.navigatorKey,
      initialRoute: Routes.SPLASH,
      routes: appRoutes,
      navigatorObservers: [router.observer],
      debugShowCheckedModeBanner: false,
      //home: HomePage(),
    );
  }
}
