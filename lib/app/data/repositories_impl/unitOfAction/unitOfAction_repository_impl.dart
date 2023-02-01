import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ja_app/app/data/repositories/eess_impl/eess_repository.dart';
import 'package:ja_app/app/data/repositories_impl/church/church_repository_impl.dart';
import 'package:ja_app/app/data/repositories_impl/eess/eess_repository_impl.dart';
import 'package:ja_app/app/domain/models/church/church.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';

import '../../../domain/models/user_data.dart';
import '../../repositories/church_impl/church_repository.dart';
import '../../repositories/unitOfAction_impl/unitOfAction_repository.dart';
import '../name_nodes/name_nodes_user.dart';

class UnitOfActionRepositoryImpl extends UnitOfActionRepository {
  final FirebaseFirestore _firestore;
  late ChurchRepositoryImpl _churchRepositoryImpl;
  late EESSRepositoryImpl _eessRepositoryImpl;

  UnitOfActionRepositoryImpl(this._firestore) {
    _churchRepositoryImpl = ChurchRepositoryImpl(_firestore);
    _eessRepositoryImpl = EESSRepositoryImpl(_firestore);
  }

  @override
  Future<UnitOfAction?> getUnitOfAction(String idUnitOfAction) async {
    try {
//log(id);
      DocumentSnapshot<Map<String, dynamic>> response =
          await _firestore.collection("unitOfAction").doc(idUnitOfAction).get();

      if (response.exists) {
        log(response.data().toString());
        return UnitOfAction.fromJson(response.data()!);
      }
    } on FirebaseFirestore catch (e) {
      log(e.app.name);
      return null;
    }
    return null;
  }

  @override
  Future<List<UnitOfAction>> getUnitOfActionAll() async {
    List<UnitOfAction> listSignUpData = [];
    // try {
    QuerySnapshot<Map<String, dynamic>> response =
        await _firestore.collection("unitOfAction").get();

    response.docs.forEach((element) {
      //print(element.data());
      listSignUpData.add(UnitOfAction.fromJson(element.data()));
    });

    return listSignUpData;
    /* } on FirebaseFirestore catch (e) {
      return listSignUpData;
    }*/
  }

  @override
  Future<List<UnitOfAction>> getUnitOfActionAllByEESS(String idEESS) async {
    try {
      List<UnitOfAction> list = [];
      QuerySnapshot<Map<String, dynamic>> response = await _firestore
          .collection("unitOfAction")
          .where("idEESS", isEqualTo: idEESS)
          .get();

      if (response.docChanges.isNotEmpty) {
        for (var element in response.docs) {
          //print(element.data());
          list.add(UnitOfAction.fromJson(element.data()));
        }

        return list;
      }

      return list;
    } on bool catch (e) {
      return [];
    }
  }

  @override
  Future<List<UserData>> getMembersToUnitAction(String idUnitAction) async {
    List<UserData> listEESS = [];
    try {
      final docRef =
          await _firestore.collection("unitOfAction").doc(idUnitAction).get();
      if (docRef.exists) {
        final UnitOfAction? unitOfAction =
            UnitOfAction.fromJson(docRef.data()!);

        if (unitOfAction != null) {
          for (var element in unitOfAction.members) {
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
  Future<bool> registerMemberUnitOfAction(
      List<String> idMember, String idEESS, idUnitOfAction) async {
    try {
      await _firestore
          .collection("unitOfAction")
          .doc(idUnitOfAction)
          .update({"members": FieldValue.arrayUnion(idMember)});

      return true;
    } on bool catch (e) {
      return false;
    }
  }

  @override
  Future<List<UserData>> getMembersEESSNoneToUnitOfAction(String idEESS) async {
    List<UserData> listEESS = [];
    try {
      final eess = await _eessRepositoryImpl.getEESS(idEESS);
      final listUnitOfActions = await getUnitOfActionAllByEESS(idEESS);
      if (eess != null) {
        List<String>? membersEESS = eess.members;
        List<String> membersNone = [];
        if (membersEESS != null && membersEESS.isNotEmpty) {
          List<String> allMembersUnitOfActions = [];

          for (var unitAction in listUnitOfActions) {
            allMembersUnitOfActions.addAll(unitAction.members);
          }

          for (var memberEESS in membersEESS) {
            if (!allMembersUnitOfActions.contains(memberEESS)) {
              membersNone.add(memberEESS);
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
  Future<UnitOfAction?> registerUnitOfAction(String nameUnitOfAction,
      String idLeaderUnitOfAction, String idEESS) async {
    try {
      final id = _firestore.collection("unitOfAction").doc().id;
      UnitOfAction unitOfAction =
          UnitOfAction(id, idEESS, idLeaderUnitOfAction, nameUnitOfAction, []);

      final response = await _firestore
          .collection("unitOfAction")
          .doc(id)
          .set(unitOfAction.toJson());

      return unitOfAction;
    } on UnitOfAction catch (e) {
      return null;
    }
  }

  @override
  Future<UnitOfAction?> isLeaderToUnitOfAction(String idMember) async {
    /*try {*/
    UnitOfAction? unitOfAction;
    QuerySnapshot<Map<String, dynamic>> response = await _firestore
        .collection("unitOfAction")
        .where("leader", isEqualTo: idMember)
        .get();

    if (response.docs.isNotEmpty) {
      return UnitOfAction.fromJson(response.docs.first.data());
    }

    return unitOfAction;
    /*} on UnitOfAction catch (e) {
      return null;
    }*/
  }

  @override
  Future<UnitOfAction?> isMemberToUnitOfAction(String idMember) async {
    /* try {*/
    UnitOfAction? unitOfAction;
    QuerySnapshot<Map<String, dynamic>> response = await _firestore
        .collection("unitOfAction")
        .where("members", arrayContains: idMember)
        .get();
    log(response.docs.toString());

    if (response.docs.isNotEmpty) {
      log("sssssssssiiiiiiiiiiiii");
      return UnitOfAction.fromJson(response.docs.first.data());
    }

    return unitOfAction;
    /*} on UnitOfAction catch (e) {
      return null;
    }*/
  }
}
