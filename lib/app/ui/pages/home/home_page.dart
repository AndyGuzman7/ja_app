import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/repositories/authentication_repository.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/side_menu/side_menu.dart';
import 'package:ja_app/app/ui/pages/home/controller/home_controller.dart';
import 'package:ja_app/app/ui/pages/home/widgets/item_button.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

final homeProvider = SimpleProvider(
  (_) => HomeController(),
);

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*ProviderListener<HomeController>(provider: homeProvider, builder: (_, controller){
      return
    })*/
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          color: const Color.fromARGB(255, 253, 254, 255),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer(
                builder: (_, watch, __) {
                  final user = watch.watch(sessionProvider).user!;
                  return Container(
                    margin: EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 102, 133, 230),
                          Color.fromARGB(255, 127, 159, 229)
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "Welcome ${user.displayName ?? ''}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: const Text(
                            "Secretary",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        CupertinoButton(
                            color: Colors.white,
                            child: const Text(
                              "View perfil",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 13, 43, 68)),
                            ),
                            onPressed: () {})
                      ],
                    ),
                  );
                },
              ),
              Flexible(
                flex: 2,
                child: GridView.count(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: const [
                    ItemButton(
                      textTitle: "Add Members",
                      pageRoute: Routes.LIST_ESTUDENTS,
                      textSubTitle: '29 students',
                      iconButtonItem: Icon(Icons.verified_user_outlined),
                    ),
                  ],
                ),
              ),
              const Text("Home page"),
              CupertinoButton(
                child: const Text("Sign out"),
                onPressed: () async {
                  await sessionProvider.read.signOut();
                  router.pushNamedAndRemoveUntil(Routes.LOGIN);
                },
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
