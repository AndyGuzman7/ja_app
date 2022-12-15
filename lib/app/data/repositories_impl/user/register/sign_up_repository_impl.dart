import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ja_app/app/domain/models/sign_up.dart';
import 'package:ja_app/app/data/repositories/user_impl/register_impl/sign_up_repository.dart';
import 'package:ja_app/app/domain/responses/sign_up_response.dart';

class SignUpRepositoryImpl extends SignUpRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  User? user;

  SignUpRepositoryImpl(this._auth, this._firestore);
  @override
  Future<SignUpResponse> register(SignUpData data) async {
    try {
      // Get a new write batch
      final batch = _firestore.batch();

// Set the value of 'NYC'
      var nycRef = _firestore.collection("cities").doc("NYC");
      batch.set(nycRef, {"name": "New York City"});

// Update the population of 'SF'
      var sfRef = _firestore.collection("cities").doc("SF");
      batch.update(sfRef, {"population": 1000000});

// Delete the city 'LA'
      var laRef = _firestore.collection("cities").doc("LA");
      batch.delete(laRef);

// Commit the batch
      batch.commit().then((_) {
        // ...
      });
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
    return FirebaseFirestore.instance.collection("users").doc(userId).get();
  }
}
