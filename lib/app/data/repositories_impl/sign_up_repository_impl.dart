import 'package:firebase_auth/firebase_auth.dart';
import 'package:ja_app/app/domain/inputs/sign_up.dart';
import 'package:ja_app/app/domain/repositories/sign_up_repository.dart';
import 'package:ja_app/app/domain/responses/sign_up_response.dart';

class SignUpRepositoryImpl extends SignUpRepository {
  final FirebaseAuth _auth;

  SignUpRepositoryImpl(this._auth);
  @override
  Future<SignUpResponse> register(SignUpData data) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );

      await userCredential.user!.updateDisplayName(
        "${data.name} ${data.lastName}",
      );
      return SignUpResponse(null, userCredential.user);
    } on FirebaseAuthException catch (e) {
      return SignUpResponse(parseStringToSignUpError(e.code), null);
    }
  }
}
