import 'dart:developer';

import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/domain/models/sign_up.dart';
import 'package:ja_app/app/domain/models/brochure.dart';
import 'package:ja_app/app/domain/models/brochureSubscription.dart';
import 'package:ja_app/app/domain/models/subscriptionProjectMana.dart';
import 'package:ja_app/app/data/repositories/project_mana_impl/project_mana_repository.dart';
import 'package:ja_app/app/data/repositories/project_mana_impl/project_mana_subscription_repository.dart';
import 'package:ja_app/app/data/repositories/user_impl/user_repository.dart';
import 'package:ja_app/app/ui/pages/projects/widgets/admin/controller/project_mana_page_admin_state.dart';

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
