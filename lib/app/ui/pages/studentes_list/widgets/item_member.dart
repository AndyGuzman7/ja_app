import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';

class ItemMember extends StatelessWidget {
  const ItemMember({Key? key}) : super(key: key);

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
              children: const [
                Text(
                  "Juan Perez",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Miembro Espacio Joven",
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
