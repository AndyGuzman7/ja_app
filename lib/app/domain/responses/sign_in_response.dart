import 'package:firebase_auth/firebase_auth.dart';
import 'package:ja_app/app/domain/models/user_data.dart';

class SignInResponse {
  final SignInError? error;

  final UserData? userData;

  SignInResponse(this.error, this.userData);
}

enum SignInError {
  networkRequestFailed,
  userDisabled,
  userNotFound,
  wrongPassword,
  tooManyRequests,
  unknown
}

SignInError stringToSignInError(String code) {
  switch (code) {
    case "too-many-requests":
      return SignInError.tooManyRequests;
    case "user-disable":
      return SignInError.userDisabled;

    case "user-not-found":
      return SignInError.userNotFound;

    case "network-request-failed":
      return SignInError.networkRequestFailed;

    case "wrong-password":
      return SignInError.wrongPassword;

    default:
      return SignInError.unknown;
  }
}
