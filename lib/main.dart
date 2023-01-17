import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ja_app/app/inject_dependencies.dart';
import 'package:ja_app/app/my_app.dart';
import 'package:ja_app/src/providers/push_notifications_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  injectDependencies();
  await PushNotificationService.initializedApp();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    bool inDebug = false;
    assert(() {
      inDebug = true;
      return true;
    }());
    // In debug mode, use the normal error widget which shows
    // the error message:
    if (inDebug) return ErrorWidget(details.exception);
    // In release builds, show a yellow-on-blue message instead:
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Error! ${details.exception}',
        style: TextStyle(color: Colors.yellow),
        textDirection: TextDirection.ltr,
      ),
    );
  };
  runApp(const MyApp());
}
