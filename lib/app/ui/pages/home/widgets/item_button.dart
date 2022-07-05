import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';

class ItemButton extends StatelessWidget {
  final String textTitle;
  final String textSubTitle;
  final Icon iconButtonItem;

  final String pageRoute;

  const ItemButton({
    required this.textTitle,
    required this.pageRoute,
    required this.textSubTitle,
    required this.iconButtonItem,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 218, 218, 218),
              offset: Offset(0.0, 10.0),
              blurRadius: 15.0,
            ),
          ],
        ),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          margin: EdgeInsets.zero,
          color: Colors.white,
          elevation: 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              router.pushNamed(pageRoute);
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 243, 242, 242),
                    child: Icon(Icons.person),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      textTitle,
                    ),
                    subtitle: Text(textSubTitle),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
