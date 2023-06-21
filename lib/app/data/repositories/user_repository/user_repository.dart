import 'package:ja_app/app/domain/models/user_data.dart';

abstract class UserRepository {
  Future<UserData?> getUser(String id);
  Future<List<UserData>> getUsers();

  Future<List<UserData>> getMembersToIds(List<String> ids);
}
