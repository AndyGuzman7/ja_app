import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/data/repositories_impl/account_repository_impl.dart';
import 'package:ja_app/app/data/repositories_impl/authentication_repository_impl.dart';
import 'package:ja_app/app/data/repositories_impl/project_mana_repository_impl.dart';
import 'package:ja_app/app/data/repositories_impl/sign_up_repository_impl.dart';
import 'package:ja_app/app/domain/repositories/account_repository.dart';
import 'package:ja_app/app/domain/repositories/authentication_repository.dart';
import 'package:ja_app/app/domain/repositories/project_mana_repository.dart';
import 'package:ja_app/app/domain/repositories/sign_up_repository.dart';
import 'package:ja_app/app/ui/pages/projects/controller/project_mana_controller.dart';

void injectDependencies() {
  Get.lazyPut<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(FirebaseAuth.instance),
  );

  Get.lazyPut<SignUpRepository>(
    () => SignUpRepositoryImpl(FirebaseAuth.instance),
  );

  Get.lazyPut<AccountRepository>(
      () => AccountRepositoryImpl(FirebaseAuth.instance));

  Get.lazyPut<ProjectManaRepository>(
      () => ProjectManaRepositoryImpl(FirebaseFirestore.instance));
}
