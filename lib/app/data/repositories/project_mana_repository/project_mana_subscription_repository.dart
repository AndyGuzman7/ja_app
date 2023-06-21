import 'package:ja_app/app/domain/models/subscriptionProjectMana.dart';

abstract class ProjectManaSubsccriptionRepository {
  Future<List<SubscriptionProjectMana>> getSubscriptionsProjectMana();

  Future<SubscriptionProjectMana> getSubscriptionProjectMana();
}
