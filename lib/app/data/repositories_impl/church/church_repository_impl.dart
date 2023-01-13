import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ja_app/app/domain/models/church/church.dart';

import '../../repositories/church_impl/church_repository.dart';

class ChurchRepositoryImpl extends ChurchRepository {
  final FirebaseFirestore _firestore;

  ChurchRepositoryImpl(this._firestore);

  @override
  Future<bool> registerMemberChurch(String idMember, String idChurch) async {
    try {
      log(idChurch);
      await _firestore.collection("church").doc(idChurch).update({
        "members": FieldValue.arrayUnion([idMember]),
      });

      return true;
    } on bool catch (e) {
      return false;
    }
  }

  @override
  Future<Church?> isExistChurchCodeAccess(String code) async {
    try {
      QuerySnapshot<Map<String, dynamic>> response = await _firestore
          .collection("church")
          .where("codeAccess", isEqualTo: code)
          .get();

      if (response.docChanges.isNotEmpty) {
        return Church.fromJson(response.docs.elementAt(0).data());
      }

      return null;
    } on bool catch (e) {
      return null;
    }
  }

  @override
  Future<bool> registerMemberChurchCodeAcess(
      String idMember, String code) async {
    try {
      final church = await isExistChurchCodeAccess(code);

      if (church != null) {
        log(church.id);
        final register = await registerMemberChurch(idMember, church.id);
        if (!register) {
          return false;
        }
        return true;
      }

      return false;
    } on bool catch (e) {
      return false;
    }
  }

  @override
  Future<Church?> isExistChurchSuscripcion(String id) async {
    //try {
    QuerySnapshot<Map<String, dynamic>> response = await _firestore
        .collection("church")
        .where("members", arrayContains: id)
        .get();

    if (response.docChanges.isNotEmpty) {
      log(response.docs.elementAt(0).data().toString());
      return Church.fromJson(response.docs.elementAt(0).data());
    }
    return null;

    /* return null;
    } on bool catch (e) {
      return null;
    }*/
  }

  @override
  Future<Church?> getChurchWitdhIdMember(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> response = await _firestore
          .collection("church")
          .where("members", arrayContains: id)
          .get();

      if (response.docChanges.isNotEmpty) {
        return Church.fromJson(response.docs.elementAt(0).data());
      }

      return null;
    } on bool catch (e) {
      return null;
    }
  }
}
