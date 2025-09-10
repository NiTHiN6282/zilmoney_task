import '../models/user.dart';

abstract class UserRepository {
  Future<List<User>> fetchUsers();
  Future<User> fetchUser(int id);
  Future<User> editUser(User user);
  Future<void> deleteUser(int id);
  Future<User> addUser(User user);
}
