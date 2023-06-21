import 'dart:developer';

import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/domain/models/subscriptionProjectMana.dart';
import 'package:ja_app/app/ui/pages/projects/widgets/admin/controller/project_mana_page_admin_state.dart';

import '../../../../../../data/repositories/project_mana_repository/project_mana_repository.dart';
import '../../../../../../data/repositories/project_mana_repository/project_mana_subscription_repository.dart';
import '../../../../../../data/repositories/user_repository/user_repository.dart';

class ProjectManaAdminController extends StateNotifier<ProjectManaAdminState> {
  ProjectManaAdminController() : super(ProjectManaAdminState.initialState);

  final _projectManaRepository = Get.find<ProjectManaRepository>();
  final _userRepository = Get.find<UserRepository>();

  final _projectSubscription = Get.find<ProjectManaSubsccriptionRepository>();

  void onListBrochureChanged(List<SubscriptionProjectMana>? brochure) {
    state = state.copyWith(listBrochureSubscription: brochure);
  }

  Future<bool> getSubscriptionProjectMana() async {
    try {
      List<SubscriptionProjectMana>? list =
          await _projectSubscription.getSubscriptionsProjectMana();
      log(list.length.toString());

      onListBrochureChanged(list);
      return true;
    } catch (e) {}
    return false;
  }
}
