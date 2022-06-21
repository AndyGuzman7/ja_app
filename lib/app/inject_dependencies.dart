import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/data/repositories_impl/authentication_repository_impl.dart';
import 'package:ja_app/app/domain/repositories/authentication_repository.dart';

void injectDependencies() {
  Get.lazyPut<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(FirebaseAuth.instance));
}
