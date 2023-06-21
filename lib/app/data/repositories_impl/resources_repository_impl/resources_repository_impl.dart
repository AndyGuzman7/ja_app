import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ja_app/app/data/repositories_impl/name_nodes/name_nodes_user.dart';
import 'package:ja_app/app/domain/models/resources.dart';
import 'package:ja_app/app/domain/models/userAvatar.dart';

import '../../repositories/resources_repository/resources_repository.dart';

class ResourcesRepositoryImpl extends ResourcesRepository {
  final FirebaseFirestore _firestore;

  ResourcesRepositoryImpl(this._firestore);
  @override
  Future<Resources> getImagesLink() async {
    Resources? resources;
    List<String> listImages = [];
    try {
      DocumentSnapshot<Map<String, dynamic>> value = await _firestore
          .collection(NameNodesResources.NODE_MAIN_RESOURCES)
          .doc(NameNodesResources.NODE_IMAGES)
          .get();

      if (value.exists) {
        value.data()!.forEach((key, value) {
          print('$key: $value');
          listImages.add(value);
        });
        resources = Resources(listImages);

        return resources;
      }
    } on FirebaseFirestore catch (e) {
      return resources!;
    }
    return resources!;
  }

  @override
  Future<bool> registerImageAvatar(List<UserAvatar> lis) async {
    List<UserAvatar> userAvatar = [];
    String jsonTags = jsonEncode(userAvatar);
    final e = userAvatar.map((e) => e.toJson()).toString();
    try {
      await _firestore
          .collection("resources")
          .doc("avatar")
          .set(toJsonList(lis));

      return true;
    } on bool catch (e) {
      return false;
    }
  }

  Map<String, dynamic> toJsonList(List<UserAvatar> list) {
    Map<String, dynamic> d = {};
    var s = list.map((e) {
      return MapEntry(e.name, e.toJson());
    });
    d.addEntries(s);
    /*for (var element in s) {
      d.addEntries(element.value);
    }*/

    return d;
  }

  @override
  Future<List<UserAvatar>> getUservAvatarAll() async {
    List<UserAvatar>? listBrochures = [];
    try {
      DocumentSnapshot<Map<String, dynamic>> value =
          await _firestore.collection("resources").doc("avatar").get();

      if (value.exists) {
        value.data()!.forEach((key, value) {
          //log(value.toString());
          listBrochures.add(UserAvatar.fromJson(value));
          //print('$key: $value');
          //listBrochures.add(Brochure.fromJson(value));
          //log(value.toString());
        });

        return listBrochures;
      }
    } on FirebaseFirestore catch (e) {
      return listBrochures;
    }
    return listBrochures;
  }
}
