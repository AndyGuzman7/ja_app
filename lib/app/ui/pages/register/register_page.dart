import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';

import 'package:ja_app/app/ui/pages/register/controller/register_controller.dart';
import 'package:ja_app/app/ui/pages/register/controller/register_state.dart';
import 'package:ja_app/app/ui/pages/register/register_page_personal.dart';

final registerProvider = StateProvider<RegisterController, RegisterState>(
  (_) => RegisterController(sessionProvider.read),
);

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<RegisterController>(
        provider: registerProvider,
        builder: (_, controller) {
          Row rowModel(widgetOne, widgetTwo) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: widgetOne,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(child: widgetTwo),
              ],
            );
          }

          log("otra vez");

          return DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                bottom: TabBar(tabs: [
                  Tab(
                    icon: Icon(Icons.person_outline_sharp),
                  ),
                  Tab(
                    icon: Icon(Icons.domain_verification_sharp),
                  ),
                  Tab(icon: Icon(Icons.send))
                ]),
              ),
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: TabBarView(
                  children: [
                    Expanded(
                      child: RegisterPagePersonal(
                        context: context,
                      ),
                    ),
                    Expanded(
                      child: RegisterPagePersonal(
                        context: context,
                      ),
                    ),
                    Expanded(
                      child: RegisterPagePersonal(
                        context: context,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
