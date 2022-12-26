import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/pages/studentes_list/controller/students_list_controller.dart';
import 'package:ja_app/app/ui/pages/studentes_list/widgets/item_header.dart';
import 'package:ja_app/app/ui/pages/studentes_list/widgets/item_member.dart';
import 'package:ja_app/app/utils/MyColors.dart';

final studentListProvider = SimpleProvider(
  (_) => StudentsListController(sessionProvider.read),
);

class StudentsListPage extends StatelessWidget {
  const StudentsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        elevation: 0,
        title: const Text("Members"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: studentListProvider.read.getUsers(),
            builder: (context, AsyncSnapshot<List<UserData?>> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 0, top: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 0, right: 0, top: 20),
                            child: CupertinoButton(
                              child: const Text("Sign out"),
                              onPressed: () async {},
                              color: CustomColorPrimary().materialColor,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: ItemHeader(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.only(top: 20),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemMember(snapshot.data![index]!);
                          }),
                    ),
                  ],
                );
              } else {
                return WillPopScope(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                    onWillPop: () async => false);
              }
            },
          ),
        ),
      ),
    );
  }
}

class CustomButtonContainer extends StatelessWidget {
  const CustomButtonContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Material(
          color: CustomColorPrimary().materialColor,
          child: InkWell(
            child: Text("adsd"),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
