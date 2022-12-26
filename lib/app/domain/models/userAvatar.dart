import 'package:flutter/cupertino.dart';

class UserAvatar {
  bool isSelect = false;
  String url;
  Icon? icon;
  String name;
  UserAvatar(this.name, this.url, this.isSelect);
}
