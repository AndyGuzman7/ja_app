import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';

import 'package:ja_app/app/ui/pages/register/controller/register_controller.dart';
import 'package:ja_app/app/ui/pages/register/controller/register_state.dart';
import 'package:ja_app/app/ui/pages/register/register_page_avatar.dart';
import 'package:ja_app/app/ui/pages/register/register_page_personal.dart';
import 'package:ja_app/app/ui/pages/register/register_page_user.dart';

final registerProvider = StateProvider<RegisterController, RegisterState>(
    (_) => RegisterController(sessionProvider.read));

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    //registerProvider.read.tabController = TabController(length: 3, );

    return ProviderListener<RegisterController>(
      provider: registerProvider,
      builder: (_, controller) {
        final one = RegisterPageAvatar(
          providerListener: registerProvider,
        );

        final two = RegisterPagePersonal(
          providerListener: registerProvider,
          context: context,
        );

        final three = RegisterPageUser(
          providerListener: registerProvider,
          context: context,
        );

        return DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text("Registro"),
              elevation: 0,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: IgnorePointer(
                  ignoring: true,
                  child: TabBar(physics: NeverScrollableScrollPhysics(), tabs: [
                    Tab(
                      icon: Icon(Icons.person_outline_sharp),
                    ),
                    Tab(
                      icon: Icon(Icons.contact_page_rounded),
                    ),
                    Tab(icon: Icon(Icons.person_pin_sharp))
                  ]),
                ),
              ),
            ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                one,
                two,
                three,
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
