import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RowCustom extends StatelessWidget {
  final Widget widget1, widget2;
  const RowCustom(this.widget1, this.widget2, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Expanded(
          child: widget1,
        ),
        Expanded(
          child: widget2,
        ),
      ],
    );
  }
}

class RowCustomTree extends StatelessWidget {
  final Widget widget1, widget2, widget3;
  const RowCustomTree(this.widget1, this.widget2, this.widget3, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Expanded(
          child: widget1,
        ),
        Expanded(
          child: widget2,
        ),
        widget3
      ],
    );
  }
}
