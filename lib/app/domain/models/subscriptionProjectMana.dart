import 'package:ja_app/app/domain/models/sign_up.dart';
import 'package:ja_app/app/domain/models/brochure.dart';
import 'package:ja_app/app/domain/models/brochureSubscription.dart';

class SubscriptionProjectMana {
  final BrochureSubscription? brochureSubscription;
  final Brochure? brochure;
  final SignUpData? signUpData;

  SubscriptionProjectMana(
      this.brochureSubscription, this.brochure, this.signUpData);
}
