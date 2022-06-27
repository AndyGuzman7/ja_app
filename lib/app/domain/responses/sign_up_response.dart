import 'package:firebase_auth/firebase_auth.dart';
import 'package:ja_app/app/domain/responses/sign_in_response.dart';

class SignUpResponse {
  final SignUpError? error;
  final User? user;

  SignUpResponse(this.error, this.user);
}

parseStringToSignUpError(String text) {
  switch (text) {
    case "too-many-requests":
      return SignUpError.tooManyRequests;
    case "email-already-in-use":
      return SignUpError.emailAlreadyInUse;
    case "weak_password":
      return SignUpError.weakPassword;
    case "network-request-failed":
      return SignUpError.networkRequestFailed;
    default:
      return SignUpError.unknown;
  }
}

enum SignUpError {
  emailAlreadyInUse,
  weakPassword,
  unknown,
  networkRequestFailed,
  tooManyRequests
}
