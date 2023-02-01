import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ja_app/app/data/repositories_impl/name_nodes/name_nodes_user.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/data/repositories/user_impl/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseFirestore _firestore;

  UserRepositoryImpl(this._firestore);

  @override
  Future<UserData?> getUser(String id) async {
    try {
      log(id);
      DocumentSnapshot<Map<String, dynamic>> response = await _firestore
          .collection(NameNodesUser.NODE_MAIN_USERS)
          .doc(id)
          .get();

      if (response.exists) {
        return UserData.fromJson(response.data()!);
      }
    } on FirebaseFirestore catch (e) {
      log(e.app.name);
      return null;
    }
    return null;
  }

  @override
  Future<List<UserData>> getUsers() async {
    List<UserData> listSignUpData = [];
    try {
      QuerySnapshot<Map<String, dynamic>> response =
          await _firestore.collection(NameNodesUser.NODE_MAIN_USERS).get();

      response.docs.forEach((element) {
        listSignUpData.add(UserData.fromJson(element.data()));
      });

      return listSignUpData;
    } on FirebaseFirestore catch (e) {
      return listSignUpData;
    }
  }

  @override
  Future<List<UserData>> getMembersToIds(List<String> ids) async {
    List<UserData> listEESS = [];
    try {
      if (ids.isNotEmpty) {
        for (var element in ids) {
          final res = await _firestore
              .collection("users")
              .where("id", isEqualTo: element)
              .get();

          if (res.docChanges.isNotEmpty) {
            listEESS.add(UserData.fromJson(res.docs.elementAt(0).data()));
          }
        }
      }
      return listEESS;
    } on FirebaseFirestore catch (e) {
      return listEESS;
    }
  }
}
