import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ja_app/app/inject_dependencies.dart';
import 'package:ja_app/app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  injectDependencies();
  runApp(const MyApp());
}
