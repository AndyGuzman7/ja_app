import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ja_app/app/data/repositories_impl/name_nodes/name_nodes_user.dart';
import 'package:ja_app/app/domain/models/sign_up.dart';
import 'package:ja_app/app/data/repositories/user_impl/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseFirestore _firestore;

  UserRepositoryImpl(this._firestore);

  @override
  Future<SignUpData?> getUser(String id) async {
    try {
      log(id);
      DocumentSnapshot<Map<String, dynamic>> response = await _firestore
          .collection(NameNodesUser.NODE_MAIN_USERS)
          .doc(id)
          .get();

      if (response.exists) {
        log(response.data().toString());
        return SignUpData.fromJson(response.data()!);
      }
    } on FirebaseFirestore catch (e) {
      log(e.app.name);
      return null;
    }
    return null;
  }

  @override
  Future<List<SignUpData>> getUsers() async {
    List<SignUpData> listSignUpData = [];
    try {
      QuerySnapshot<Map<String, dynamic>> response =
          await _firestore.collection(NameNodesUser.NODE_MAIN_USERS).get();

      response.docs.forEach((element) {
        print(element.data());
        listSignUpData.add(SignUpData.fromJson(element.data()));
      });

      return listSignUpData;
    } on FirebaseFirestore catch (e) {
      return listSignUpData;
    }
  }
}
