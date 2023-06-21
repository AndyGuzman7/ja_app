import 'package:ja_app/app/domain/models/brochure.dart';
import 'package:ja_app/app/domain/models/brochureSubscription.dart';

abstract class ProjectManaRepository {
  Future<void> registerBrochureSubscription(
      BrochureSubscription brochureSubscription);

  Future<BrochureSubscription?> getBrochureSubscription(String idUser);

  Future<List<BrochureSubscription>> getBrochureSubscriptions();

  Future<List<Brochure>> getBrochures();

  Future<Brochure?> getBrochure(String id);
}
