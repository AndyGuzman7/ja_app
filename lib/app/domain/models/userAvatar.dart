import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserAvatar {
  bool isSelect = false;
  String url;
  Icon? icon;
  String name;
  UserAvatar({required this.name, required this.url, required this.isSelect});

  factory UserAvatar.fromJson(Map<String, dynamic> json) {
    return UserAvatar(
      name: json['name'],
      url: json['url'],
      isSelect: false,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'name': name, 'url': url};
}
