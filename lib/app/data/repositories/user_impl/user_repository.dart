import 'package:ja_app/app/domain/models/sign_up.dart';

abstract class UserRepository {
  Future<SignUpData?> getUser(String id);
  Future<List<SignUpData>> getUsers();
}
