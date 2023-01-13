import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ja_app/app/data/repositories_impl/church/church_repository_impl.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/data/repositories/user_impl/register_impl/sign_up_repository.dart';
import 'package:ja_app/app/domain/responses/sign_up_response.dart';

class SignUpRepositoryImpl extends SignUpRepository {
  late final FirebaseAuth _auth;
  late final FirebaseFirestore _firestore;
  late final ChurchRepositoryImpl _churchRepositoryImpl;
  User? user;

  SignUpRepositoryImpl(FirebaseAuth auth, firestore) {
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
        await addUserInfoToDB(user!.uid, data.toJson());
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
