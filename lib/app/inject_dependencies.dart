import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/data/repositories_impl/user/login/authentication_repository_impl.dart';
import 'package:ja_app/app/data/repositories_impl/project_mana/project_mana_repository_impl.dart';
import 'package:ja_app/app/data/repositories_impl/project_mana/project_mana_repository_subscription_impl.dart';
import 'package:ja_app/app/data/repositories_impl/resources/resources_repository_impl.dart';
import 'package:ja_app/app/data/repositories_impl/user/register/sign_up_repository_impl.dart';
import 'package:ja_app/app/data/repositories_impl/user/user_repository_impl.dart';
import 'package:ja_app/app/data/repositories/user_impl/login_impl/authentication_repository.dart';
import 'package:ja_app/app/data/repositories/project_mana_impl/project_mana_repository.dart';
import 'package:ja_app/app/data/repositories/project_mana_impl/project_mana_subscription_repository.dart';
import 'package:ja_app/app/data/repositories/resources_impl/resources_repository.dart';
import 'package:ja_app/app/data/repositories/user_impl/register_impl/sign_up_repository.dart';
import 'package:ja_app/app/data/repositories/user_impl/user_repository.dart';

void injectDependencies() {
  Get.lazyPut<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(FirebaseAuth.instance),
  );

  Get.lazyPut<SignUpRepository>(
    () =>
        SignUpRepositoryImpl(FirebaseAuth.instance, FirebaseFirestore.instance),
  );
  Get.lazyPut<ProjectManaRepository>(
      () => ProjectManaRepositoryImpl(FirebaseFirestore.instance));

  Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(FirebaseFirestore.instance));

  Get.lazyPut<ProjectManaSubsccriptionRepository>(
      () => ProjectManaRepositorySubscription(FirebaseFirestore.instance));

  Get.lazyPut<ResourcesRepository>(
      () => ResourcesRepositoryImpl(FirebaseFirestore.instance));
}
