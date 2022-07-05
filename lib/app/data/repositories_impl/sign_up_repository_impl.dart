import 'package:firebase_auth/firebase_auth.dart';
import 'package:ja_app/app/domain/inputs/sign_up.dart';
import 'package:ja_app/app/domain/repositories/sign_up_repository.dart';
import 'package:ja_app/app/domain/responses/sign_up_response.dart';

class SignUpRepositoryImpl extends SignUpRepository {
  final FirebaseAuth _auth;
  User? user;

  SignUpRepositoryImpl(this._auth);
  @override
  Future<SignUpResponse> register(SignUpData data) async {
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

      return SignUpResponse(null, user);
    } on FirebaseAuthException catch (e) {
      return SignUpResponse(parseStringToSignUpError(e.code), null);
    }
  }

  Future<UserCredential> updateName(
      UserCredential userCredential, String name) async {
    await userCredential.user!.updateDisplayName(name);
    print(userCredential.user!.displayName);
    return userCredential;
  }
}
