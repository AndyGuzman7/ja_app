import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ja_app/app/inject_dependencies.dart';
import 'package:ja_app/app/my_app.dart';
import 'package:ja_app/app/ui/routes/app_routes.dart';

import 'app/ui/routes/routes.dart';
import 'pages/homePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  injectDependencies();
  runApp(const MyApp());
}
