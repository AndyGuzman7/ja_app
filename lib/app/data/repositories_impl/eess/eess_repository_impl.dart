import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ja_app/app/data/repositories/eess_impl/eess_repository.dart';
import 'package:ja_app/app/data/repositories_impl/church/church_repository_impl.dart';
import 'package:ja_app/app/domain/models/church/church.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/ui/pages/navigator_botton/color.dart';
import 'package:ja_app/app/utils/MyColors.dart';

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
      DocumentSnapshot<Map<String, dynamic>> response =
          await _firestore.collection("EESS").doc(id).get();

      if (response.exists) {
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
      final eess = await getEESS(idEESS);

      if (eess == null) {
        return [];
      }
      var members = eess.members;
      if (members == null) {
        return [];
      }
      listEESS = await getMembersToIds(members);
      return listEESS;
    } on FirebaseFirestore catch (e) {
      return listEESS;
    }
  }

  Future<List<UserData>> getMembersToIds(List<String> listIds) async {
    List<UserData> listEESS = [];
    try {
      if (listIds.isNotEmpty) {
        var countFor = (listIds.length / 10);
        countFor = ((countFor % 1 != 0 ? countFor + 1 : countFor));
        int count = 1;
        while (count <= countFor) {
          var list = listIds.take(10).toList();

          final res = await _firestore
              .collection("users")
              .where("id", whereIn: list)
              .get();

          if (res.docChanges.isNotEmpty) {
            listEESS.addAll(res.docs.map((e) => UserData.fromJson(e.data())));
          }
          count++;
          listIds.removeRange(0, list.length);
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
          listEESS = await getMembersToIds(e.members);
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
          for (var e in members) {
            for (var element in eess.unitOfAction) {
              if (!element.members.contains(e)) {
                if (membersNone.contains(e) == false) {
                  membersNone.add(e);
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

  @override
  Future<List<UserData>> getMembersChurchNoneEESS(
      String idEESS, idChurch) async {
    List<UserData> listEESS = [];

    ///try {
    final church = await _churchRepositoryImpl.getChurch(idChurch);
    final eessList = await getEESSByChurch(idChurch);
    if (church != null) {
      List<String> membersChurch = church.members;
      List<String> membersNone = [];
      if (membersChurch.isNotEmpty) {
        List<String> allMembersEESS = [];

        for (var eess in eessList) {
          allMembersEESS.addAll(eess.members!);
        }

        for (var memberChurch in membersChurch) {
          if (!allMembersEESS.contains(memberChurch)) {
            membersNone.add(memberChurch);
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

      ///CustomColorPrimary()
    }
    return listEESS;
    /* } on FirebaseFirestore catch (e) {
      return listEESS;
    }*/
  }

  @override
  Future<bool> registerMembersEESS(
      List<String> idMembers, String idEESS) async {
    try {
      await _firestore
          .collection("EESS")
          .doc(idEESS)
          .update({"members": FieldValue.arrayUnion(idMembers)});

      return true;
    } on bool catch (e) {
      return false;
    }
  }
}
