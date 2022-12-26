import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/domain/models/brochure.dart';
import 'package:ja_app/app/domain/models/brochureSubscription.dart';
import 'package:ja_app/app/domain/models/subscriptionProjectMana.dart';
import 'package:ja_app/app/data/repositories/project_mana_impl/project_mana_repository.dart';
import 'package:ja_app/app/data/repositories/project_mana_impl/project_mana_subscription_repository.dart';
import 'package:ja_app/app/data/repositories/user_impl/user_repository.dart';

class ProjectManaRepositorySubscription
    extends ProjectManaSubsccriptionRepository {
  final FirebaseFirestore _firestore;
  final _projectManaRepository = Get.find<ProjectManaRepository>();
  final _userRepository = Get.find<UserRepository>();

  ProjectManaRepositorySubscription(this._firestore);

  @override
  Future<List<SubscriptionProjectMana>> getSubscriptionsProjectMana() async {
    List<SubscriptionProjectMana> listSubsciptionsProjectMana = [];

    List<BrochureSubscription>? listBrochureSubscriptions =
        await _projectManaRepository.getBrochureSubscriptions();

    List<UserData> listSignUpDatas = await _userRepository.getUsers();

    List<Brochure>? listBrochures = await _projectManaRepository.getBrochures();

    for (var user in listSignUpDatas) {
      BrochureSubscription subscripcion = listBrochureSubscriptions.firstWhere(
          (BrochureSubscription brochureSubscription) =>
              brochureSubscription.idUser == user.id,
          orElse: () => BrochureSubscription.inits());

      // print(subscripcion.idBrochure);
      Brochure? brochure = listBrochures.firstWhere(
          (element) => element.id == subscripcion.idBrochure,
          orElse: () => Brochure.init());

      SubscriptionProjectMana subscriptionProjectMana =
          SubscriptionProjectMana(subscripcion, brochure, user);
      listSubsciptionsProjectMana.add(subscriptionProjectMana);
    }

    return listSubsciptionsProjectMana;
  }

  @override
  Future<SubscriptionProjectMana> getSubscriptionProjectMana() {
    // TODO: implement getSubscriptionProjectMana
    throw UnimplementedError();
  }
}
