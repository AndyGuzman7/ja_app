import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:ja_app/app/data/repositories/eess_impl/eess_repository.dart';
import 'package:ja_app/app/data/repositories_impl/church/church_repository_impl.dart';
import 'package:ja_app/app/data/repositories_impl/eess/eess_repository_impl.dart';
import 'package:ja_app/app/domain/models/church/church.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/target_virtual/target_virtual.dart';

import '../../../domain/models/user_data.dart';
import '../../repositories/church_impl/church_repository.dart';
import '../../repositories/target_virtual/target_virtual_repository.dart';
import '../../repositories/unitOfAction_impl/unitOfAction_repository.dart';
import '../name_nodes/name_nodes_user.dart';

class TargetVirtualRepositoryImpl extends TargetVirtualRepository {
  final FirebaseFirestore _firestore;
  late ChurchRepositoryImpl _churchRepositoryImpl;
  late EESSRepositoryImpl _eessRepositoryImpl;

  TargetVirtualRepositoryImpl(this._firestore) {
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
  Future<bool> registerTargetVirtual(String idUnitOfAction) async {
    try {
      final id = _firestore.collection("EESS_targetVirtual").doc().id;
      TargetVirtual targetVirtual = TargetVirtual(id, idUnitOfAction, null);

      final response = await _firestore
          .collection("EESS_targetVirtual")
          .doc(id)
          .set(targetVirtual.toJson());

      return true;
    } on UnitOfAction catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isExistAttendanceNowByIdTrgetVirtual(
      String idTargetVirtual, DateTime dateTime) async {
    final dateNow = DateFormat.yMd("EN").format(dateTime);

    DateFormat format = DateFormat("MM/dd/yyyy");
    log(idTargetVirtual);
    print(format.parse(dateNow));
    final res = await _firestore
        .collection("EESS_unitOfAction_attendance")
        .where("date", isEqualTo: format.parse(dateNow))
        .where("idTargetVirtual", isEqualTo: idTargetVirtual)
        .get();

    if (res.docs.isEmpty) {
      return false;
    }
    res.docChanges.forEach((element) {
      log(element.doc.data().toString());
    });
    return true;
  }

  @override
  Future<bool> registerAttendanceToTargetVirtual(
      DateTime dateTime, String idTargetVirtual, List<Attendance>? list) async {
    /* try {*/
    final id = _firestore.collection("EESS_unitOfAction_attendance").doc().id;

    final dateNow = DateFormat.yMd("EN").format(dateTime);

    DateFormat format = DateFormat("MM/dd/yyyy");
    print(format.parse(dateNow));
    final dayAttendance =
        DayAtendance(id, idTargetVirtual, format.parse(dateNow), list ?? []);
    await _firestore
        .collection("EESS_unitOfAction_attendance")
        .doc(id)
        .set(dayAttendance.toJson());

    return true;
    /*} on bool catch (e) {
      return false;
    }*/
  }

  @override
  Future<TargetVirtual?> getTargetVirtualByUnitOfAction(
      String idUnitOfAction) async {
    try {
      List<UnitOfAction> list = [];
      QuerySnapshot<Map<String, dynamic>> response = await _firestore
          .collection("EESS_targetVirtual")
          .where("idUnitOfAction", isEqualTo: idUnitOfAction)
          .get();

      if (response.docChanges.isNotEmpty) {
        final res = TargetVirtual.fromJson(response.docs.first.data());
        //print(element.data());

        return res;
      }

      return null;
    } on bool catch (e) {
      return null;
    }
  }

  @override
  Future<Attendance?> getAttendance(String idAttendance) async {
    try {
      //log(id);
      DocumentSnapshot<Map<String, dynamic>> response = await _firestore
          .collection("EESS_unitOfAction_attendance")
          .doc(idAttendance)
          .get();

      if (response.exists) {
        return Attendance.fromJson(response.data()!);
      }
    } on FirebaseFirestore catch (e) {
      log(e.app.name);
      return null;
    }
    return null;
  }

  @override
  Future<TargetVirtual?> getTargetVirtual(String idTargetVirtual) async {
    try {
      //log(id);
      DocumentSnapshot<Map<String, dynamic>> response = await _firestore
          .collection("EESS_targetVirtual")
          .doc(idTargetVirtual)
          .get();

      if (response.exists) {
        return TargetVirtual.fromJson(response.data()!);
      }
    } on FirebaseFirestore catch (e) {
      log(e.app.name);
      return null;
    }
    return null;
  }

  @override
  Future<DayAtendance?> getAttendanceNowByIdTrgetVirtual(
      String idTargetVirtual, DateTime dateTime) async {
    final dateNow = DateFormat.yMd("EN").format(dateTime);

    DateFormat format = DateFormat("MM/dd/yyyy");

    final res = await _firestore
        .collection("EESS_unitOfAction_attendance")
        .where("date", isEqualTo: format.parse(dateNow))
        .where("idTargetVirtual", isEqualTo: idTargetVirtual)
        .get();

    if (res.docs.isEmpty) {
      return null;
    }

    return DayAtendance.fromJson(res.docs.first.data());
  }

  @override
  Future<bool> registerMemberToAttendance(
      List<Attendance> listAttendance, String idAttendaance) async {
    try {
      final s = listAttendance.map((e) => e.toJson()).toList();
      await _firestore
          .collection("EESS_unitOfAction_attendance")
          .doc(idAttendaance)
          .update({
        "attendance": listAttendance.map((e) => e.toJson()).toList(),
      });

      return true;
    } on bool catch (e) {
      return false;
    }
  }
}
