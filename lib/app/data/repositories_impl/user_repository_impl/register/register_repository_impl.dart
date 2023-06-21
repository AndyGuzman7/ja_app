import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ja_app/app/data/repositories_impl/church_repository_impl/church_repository_impl.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/domain/responses/sign_up_response.dart';

import '../../../repositories/register_repository/register_repository.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  late final FirebaseAuth _auth;
  late final FirebaseFirestore _firestore;
  late final ChurchRepositoryImpl _churchRepositoryImpl;
  User? user;

  RegisterRepositoryImpl(FirebaseAuth auth, firestore) {
    _auth = auth;
    _firestore = firestore;
    _churchRepositoryImpl = ChurchRepositoryImpl(_firestore);
  }
  @override
  Future<SignUpResponse> register(UserData data) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );

      user = userCredential.user;
      await user!.updateDisplayName(data.name);
      await user!.reload();

      user = _auth.currentUser;

      if (userCredential != null) {
        data.id = user!.uid;
        final response = await addUserInfoToDB(user!.uid, data.toJson());
      }

      return SignUpResponse(null, user, data);
    } on FirebaseAuthException catch (e) {
      return SignUpResponse(parseStringToSignUpError(e.code), null, null);
    }
  }

  Future<UserCredential> updateName(
      UserCredential userCredential, String name) async {
    await userCredential.user!.updateDisplayName(name);
    print(userCredential.user!.displayName);
    return userCredential;
  }

  Future addUserInfoToDB(String userId, Map<String, dynamic> userInfoMap) {
    return _firestore.collection("users").doc(userId).set(userInfoMap);
  }

  Future<DocumentSnapshot> getUserFromDB(String userId) async {
    return _firestore.collection("users").doc(userId).get();
  }
}
