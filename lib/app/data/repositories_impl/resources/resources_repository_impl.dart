import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ja_app/app/data/repositories_impl/name_nodes/name_nodes_user.dart';
import 'package:ja_app/app/domain/models/resources.dart';
import 'package:ja_app/app/data/repositories/resources_impl/resources_repository.dart';
import 'package:ja_app/app/domain/models/userAvatar.dart';

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
  Future<bool> registerImageAvatar() async {
    List<UserAvatar> userAvatar = [];
    String jsonTags = jsonEncode(userAvatar);
    final e = userAvatar.map((e) => e.toJson()).toString();
    try {
      await _firestore
          .collection("resources")
          .doc("images")
          .collection(jsonTags);

      return true;
    } on bool catch (e) {
      return false;
    }
  }
}
