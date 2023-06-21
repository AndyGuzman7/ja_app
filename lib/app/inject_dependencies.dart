import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/data/repositories_impl/project_mana_repository_impl/project_mana_subscription_repository_impl.dart';

import 'data/repositories/church_repository/church_repository.dart';
import 'data/repositories/eess_repository/eess_repository.dart';
import 'data/repositories/login_repository/login_repository.dart';
import 'data/repositories/project_mana_repository/project_mana_repository.dart';
import 'data/repositories/project_mana_repository/project_mana_subscription_repository.dart';
import 'data/repositories/register_repository/register_repository.dart';
import 'data/repositories/resources_repository/resources_repository.dart';
import 'data/repositories/target_virtual_repository/target_virtual_repository.dart';
import 'data/repositories/unitOfAction_repository/unitOfAction_repository.dart';
import 'data/repositories/user_repository/user_repository.dart';
import 'data/repositories_impl/church_repository_impl/church_repository_impl.dart';
import 'data/repositories_impl/eess_repository_impl/eess_repository_impl.dart';
import 'data/repositories_impl/project_mana_repository_impl/project_mana_repository_impl.dart';
import 'data/repositories_impl/resources_repository_impl/resources_repository_impl.dart';
import 'data/repositories_impl/targetVirtual_repository_impl/target_virtual_repository_impl.dart';
import 'data/repositories_impl/unitOfAction_repository_impl/unitOfAction_repository_impl.dart';
import 'data/repositories_impl/user_repository_impl/login/login_repository_impl.dart';
import 'data/repositories_impl/user_repository_impl/register/register_repository_impl.dart';
import 'data/repositories_impl/user_repository_impl/user_repository_impl.dart';

void injectDependencies() {
  Get.lazyPut<LoginRepository>(
    () =>
        LoginRepositoryImpl(FirebaseAuth.instance, FirebaseFirestore.instance),
  );

  Get.lazyPut<RegisterRepository>(
    () => RegisterRepositoryImpl(
        FirebaseAuth.instance, FirebaseFirestore.instance),
  );
  Get.lazyPut<ProjectManaRepository>(
      () => ProjectManaRepositoryImpl(FirebaseFirestore.instance));

  Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(FirebaseFirestore.instance));

  Get.lazyPut<ProjectManaSubsccriptionRepository>(
      () => ProjectManaSubscriptionRepositoryImpl(FirebaseFirestore.instance));

  Get.lazyPut<ResourcesRepository>(
      () => ResourcesRepositoryImpl(FirebaseFirestore.instance));
  Get.lazyPut<ChurchRepository>(
      () => ChurchRepositoryImpl(FirebaseFirestore.instance));
  Get.lazyPut<EESSRepository>(
      () => EESSRepositoryImpl(FirebaseFirestore.instance));

  Get.lazyPut<UnitOfActionRepository>(
      () => UnitOfActionRepositoryImpl(FirebaseFirestore.instance));

  Get.lazyPut<TargetVirtualRepository>(
      () => TargetVirtualRepositoryImpl(FirebaseFirestore.instance));
}
