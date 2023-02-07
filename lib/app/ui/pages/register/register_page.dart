import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/pages/register/controller/register_controller.dart';
import 'package:ja_app/app/ui/pages/register/controller/register_state.dart';

final registerProvider = StateProvider<RegisterController, RegisterState>(
    (_) => RegisterController(sessionProvider.read));

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<RegisterController>(
      provider: registerProvider,
      builder: (_, controller) {
        return DefaultTabController(
          length: registerProvider.read.listTabBar.length,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("Registro"),
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40),
                child: IgnorePointer(
                  ignoring: true,
                  child: TabBar(
                      physics: const NeverScrollableScrollPhysics(),
                      tabs: registerProvider.read.listTabBar
                          .map((e) => e.tabBar)
                          .toList()),
                ),
              ),
            ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: registerProvider.read.listTabBar
                  .map((e) => e.children)
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
