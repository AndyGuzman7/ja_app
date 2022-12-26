import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/user_data.dart';

class ItemMember extends StatelessWidget {
  UserData user;
  ItemMember(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 1, bottom: 1),
      color: Color.fromARGB(255, 255, 255, 255),
      elevation: 0,
      child: InkWell(
        //borderRadius: BorderRadius.circular(16),
        onTap: () {
          //router.pushNamed(pageRoute);
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                width: 60,
                height: 60,
                child: Container(),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name + " " + user.lastName,
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      user.email + " " + user.lastName,
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 123, 123, 123)),
                    )),
                Text(
                  "Usuario registrado",
                  style: TextStyle(color: Color.fromARGB(255, 13, 97, 167)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
