import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/domain/models/brochure.dart';
import 'package:ja_app/app/domain/models/brochureSubscription.dart';
import 'package:ja_app/app/domain/models/subscriptionProjectMana.dart';

class ProjectManaAdminState {
  final List<SubscriptionProjectMana>? listBrochureSubscription;

  ProjectManaAdminState({
    required this.listBrochureSubscription,
  });

  static ProjectManaAdminState get initialState =>
      ProjectManaAdminState(listBrochureSubscription: null);

  ProjectManaAdminState copyWith({
    List<SubscriptionProjectMana>? listBrochureSubscription,
  }) {
    return ProjectManaAdminState(
      listBrochureSubscription:
          listBrochureSubscription ?? this.listBrochureSubscription,
    );
  }
}
