import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/repositories/authentication_repository.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer(
            builder: (_, watch, __) {
              final user = watch.watch(sessionProvider).user!;
              return Text(user.displayName ?? '');
            },
          ),
          Text("Home page"),
          CupertinoButton(
            child: Text("Sign out"),
            onPressed: () async {
              await sessionProvider.read.signOut();
              router.pushNamedAndRemoveUntil(Routes.LOGIN);
            },
            color: Colors.blue,
          )
        ],
      )),
    );
  }
}
