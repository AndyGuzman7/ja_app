import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ja_app/app/domain/models/brochure.dart';
import 'package:ja_app/app/domain/models/brochureSubscription.dart';
import 'package:ja_app/app/domain/repositories/project_mana_repository.dart';

import 'package:firebase_database/firebase_database.dart';

class ProjectManaRepositoryImpl implements ProjectManaRepository {
  final FirebaseFirestore _firestore;

  ProjectManaRepositoryImpl(this._firestore);
  @override
  Future<void> registerBrochureSubscription(
      BrochureSubscription brochureSubscription) async {
    try {
      _firestore
          .collection(NameFirebaseFirestoreProjects.PROJECT_MAIN)
          .doc(NameFirebaseFirestoreProjects.PROJECT_MANA)
          .collection('brochureSubscription')
          .doc(brochureSubscription.idUser)
          .set(brochureSubscription.toJson())
          .then((value) {});
    } on FirebaseFirestore catch (e) {}
  }

  Future addUserInfoToDB(String userId, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  @override
  Future<BrochureSubscription?> getBrochureSubscription(String idUser) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> value = await _firestore
          .collection(NameFirebaseFirestoreProjects.PROJECT_MAIN)
          .doc(NameFirebaseFirestoreProjects.PROJECT_MANA)
          .collection("brochureSubscription")
          .doc(idUser)
          .get();

      if (value.exists) {
        BrochureSubscription brochureSubscription =
            BrochureSubscription.fromJson(value.data()!);
        return brochureSubscription;
      }
    } on FirebaseFirestore catch (e) {
      return null;
    }
    return null;
  }

  @override
  Future<List<Brochure>?> getBrochures() async {
    List<Brochure>? listBrochures = [];
    try {
      DocumentSnapshot<Map<String, dynamic>> value = await _firestore
          .collection(NameFirebaseFirestoreProjects.PROJECT_MAIN)
          .doc(NameFirebaseFirestoreProjects.BROCHURES)
          .get();

      if (value.exists) {
        value.data()!.forEach((key, value) {
          print('$key: $value');
          listBrochures.add(Brochure.fromJson(value));
        });

        return listBrochures;
      }
    } on FirebaseFirestore catch (e) {
      return null;
    }
    return null;
  }

  @override
  Future<Brochure?> getBrochure(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> value = await _firestore
          .collection(NameFirebaseFirestoreProjects.PROJECT_MAIN)
          .doc(NameFirebaseFirestoreProjects.BROCHURES)
          .get();

      dynamic nested = value.get(FieldPath([id]));

      print(nested);
      if (nested.exists) {
        return Brochure.fromJson(nested);
      }
    } on FirebaseFirestore catch (e) {
      return null;
    }
    return null;
  }
}

abstract class NameFirebaseFirestoreProjects {
  static const String PROJECT_MAIN = 'Projects';
  static const String PROJECT_MANA = 'project_mana';

  static const String BROCHURES = 'brochure';
}
