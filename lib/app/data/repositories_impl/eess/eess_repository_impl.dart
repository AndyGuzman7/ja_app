import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ja_app/app/data/repositories/eess_impl/eess_repository.dart';
import 'package:ja_app/app/data/repositories_impl/church/church_repository_impl.dart';
import 'package:ja_app/app/domain/models/church/church.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';

import '../../../domain/models/user_data.dart';
import '../../repositories/church_impl/church_repository.dart';

class EESSRepositoryImpl extends EESSRepository {
  final FirebaseFirestore _firestore;
  late ChurchRepositoryImpl _churchRepositoryImpl;

  EESSRepositoryImpl(this._firestore) {
    _churchRepositoryImpl = ChurchRepositoryImpl(_firestore);
  }

  @override
  Future<EESS?> isExistEESSSuscripcion(String id) async {
    //try {
    QuerySnapshot<Map<String, dynamic>> response = await _firestore
        .collection("EESS")
        .where("members", arrayContains: id)
        .get();

    if (response.docChanges.isNotEmpty) {
      log(response.docs.elementAt(0).data().toString());
      return EESS.fromJson(response.docs.elementAt(0).data());
    }
    return null;

    /* return null;
    } on bool catch (e) {
      return null;
    }*/
  }

  @override
  Future<EESS?> getEESS(String id) async {
    try {
      log(id);
      DocumentSnapshot<Map<String, dynamic>> response =
          await _firestore.collection("EESS").doc(id).get();

      if (response.exists) {
        log(response.data().toString());
        return EESS.fromJson(response.data()!);
      }
    } on FirebaseFirestore catch (e) {
      log(e.app.name);
      return null;
    }
    return null;
  }

  @override
  Future<List<EESS>> getEESSAll() async {
    List<EESS> listEESS = [];
    try {
      QuerySnapshot<Map<String, dynamic>> response =
          await _firestore.collection("EESS").get();

      for (var element in response.docs) {
        listEESS.add(EESS.fromJson(element.data()));
      }

      return listEESS;
    } on FirebaseFirestore catch (e) {
      return listEESS;
    }
  }

  @override
  Future<bool> registerMemberEESS(String idMember, String idEESS) async {
    try {
      await _firestore.collection("EESS").doc(idEESS).update({
        "members": FieldValue.arrayUnion([idMember]),
      });

      return true;
    } on bool catch (e) {
      return false;
    }
  }

  @override
  Future<bool> registerMemberChurchCodeAcess(String idMember, String code) {
    // TODO: implement registerMemberChurchCodeAcess
    throw UnimplementedError();
  }

  @override
  Future<EESS?> isExistEESSCodeAccess(String code) {
    // TODO: implement isExistEESSCodeAccess
    throw UnimplementedError();
  }

  @override
  Future<List<EESS>> getEESSByChurch(String idChurch) async {
    List<EESS> listEESS = [];
    try {
      final docRef = await _firestore.collection("church").doc(idChurch).get();
      if (docRef.exists) {
        Church church = Church.fromJson(docRef.data()!);
        for (var element in church.eess) {
          final res = await _firestore
              .collection("EESS")
              .where("id", isEqualTo: element)
              .get();

          if (res.docChanges.isNotEmpty) {
            listEESS.add(EESS.fromJson(res.docs.elementAt(0).data()));
          }
        }
      }
      return listEESS;
    } on FirebaseFirestore catch (e) {
      return listEESS;
    }
  }

  @override
  Future<List<UserData>> getMembersEESS(String idEESS) async {
    List<UserData> listEESS = [];
    try {
      final docRef = await _firestore.collection("EESS").doc(idEESS).get();
      if (docRef.exists) {
        EESS eess = EESS.fromJson(docRef.data()!);
        for (var element in eess.members!) {
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

  @override
  Future<EESS?> getEESSWitdhIdMember(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> response = await _firestore
          .collection("EESS")
          .where("members", arrayContains: id)
          .get();

      if (response.docChanges.isNotEmpty) {
        return EESS.fromJson(response.docs.elementAt(0).data());
      }

      return null;
    } on bool catch (e) {
      return null;
    }
  }

  @override
  Future<List<UserData>> getUnitOfAction(String idEESS) {
    // TODO: implement getUnitOfAction
    throw UnimplementedError();
  }

  @override
  Future<List<UserData>> getMembersToUnitAction(
      String idUnitAction, String idEESS) async {
    List<UserData> listEESS = [];
    try {
      final docRef = await _firestore.collection("EESS").doc(idEESS).get();
      if (docRef.exists) {
        EESS eess = EESS.fromJson(docRef.data()!);
        UnitOfAction? e = eess.unitOfAction
            .where((element) => element.id == idUnitAction)
            .first;
        if (e != null) {
          for (var element in e.members) {
            final res = await _firestore
                .collection("users")
                .where("id", isEqualTo: element)
                .get();

            if (res.docChanges.isNotEmpty) {
              log("hay lista");
              listEESS.add(UserData.fromJson(res.docs.elementAt(0).data()));
            }
          }
        }
      }
      return listEESS;
    } on FirebaseFirestore catch (e) {
      return listEESS;
    }
  }

  @override
  Future<List<UserData>> getMembersEESSNoneToUnitOfAction(String idEESS) async {
    List<UserData> listEESS = [];
    try {
      final docRef = await _firestore.collection("EESS").doc(idEESS).get();
      if (docRef.exists) {
        EESS eess = EESS.fromJson(docRef.data()!);
        List<String>? members = eess.members;
        List<String> membersNone = [];
        if (members != null) {
          log("entra a los miembros" + members.length.toString());
          for (var e in members) {
            log(e);
            for (var element in eess.unitOfAction) {
              log(element.name);
              if (!element.members.contains(e)) {
                if (membersNone.contains(e) == false) {
                  membersNone.add(e);
                  log(e);
                }
              }
            }
          }
        }

        for (var element in membersNone) {
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

  @override
  Future<bool> registerMemberEESSUnitOfAction(
      List<String> idMembers, String idEESS, idUnitOfAction) async {
    try {
      await _firestore.collection("EESS").doc(idEESS).update({
        "unitOfAction": {
          idUnitOfAction: {"members": FieldValue.arrayUnion(idMembers)}
        },
      });

      return true;
    } on bool catch (e) {
      return false;
    }
  }
}
