import 'package:dio/dio.dart';
import 'package:zilmoney_task/models/user.dart';
import 'package:zilmoney_task/repositories/user_repository.dart';
import 'package:zilmoney_task/utils/constants.dart';

class UserRepositoryImpl implements UserRepository {
  Dio dio;
  UserRepositoryImpl(this.dio);
  @override
  Future<List<User>> fetchUsers() async {
    try {
      var response = await dio.get(baseUrl);
      return (response.data as List).map((e) => User.fromMap(e)).toList();
    } catch (e) {
      throw "$e";
    }
  }

  @override
  Future<User> fetchUser(int id) async {
    try {
      var response = await dio.get("$baseUrl/$id");
      return User.fromMap(response.data);
    } catch (e) {
      throw "$e";
    }
  }

  @override
  Future<void> deleteUser(int id) async {
    try {
      await dio.delete("$baseUrl/$id");
    } catch (e) {
      throw "$e";
    }
  }

  @override
  Future<User> editUser(User user) async {
    try {
      var response = await dio.put("$baseUrl/${user.id}", data: user.toMap());
      return User.fromMap(response.data);
    } catch (e) {
      throw "$e";
    }
  }

  @override
  Future<User> addUser(User user) async {
    try {
      var response = await dio.post(baseUrl, data: user.toMap());
      return User.fromMap(response.data);
    } catch (e) {
      throw "$e";
    }
  }
}
