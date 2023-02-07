import 'package:firebase_auth/firebase_auth.dart';
import 'package:ja_app/app/domain/models/resources.dart';

import '../../../domain/models/userAvatar.dart';

abstract class ResourcesRepository {
  Future<Resources> getImagesLink();
  Future<List<UserAvatar>> getUservAvatarAll();
  Future<bool> registerImageAvatar(List<UserAvatar> lis);
}
