import 'package:firebase_auth/firebase_auth.dart';
import 'package:ja_app/app/domain/models/resources.dart';

abstract class ResourcesRepository {
  Future<Resources> getImagesLink();
}