import 'package:ja_app/app/domain/models/user_data.dart';

abstract class UserRepository {
  Future<UserData?> getUser(String id);
  Future<List<UserData>> getUsers();
}
