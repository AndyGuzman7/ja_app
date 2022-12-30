import 'package:cloud_firestore/cloud_firestore.dart';

import '../../repositories/church_impl/church_repository.dart';

class ChurchRepositoryImpl extends ChurchRepository {
  final FirebaseFirestore _firestore;

  ChurchRepositoryImpl(this._firestore);

  @override
  Future<bool> registerMemberChurch(String idMember, String idChurch) async {
    try {
      await _firestore.collection("church").doc(idChurch).update({
        "members": FieldValue.arrayUnion([idMember]),
      });

      return true;
    } on bool catch (e) {
      return false;
    }
  }
}
