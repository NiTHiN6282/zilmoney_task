import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zilmoney_task/providers/dio_provider.dart';
import 'package:zilmoney_task/repositories/user_repository.dart';
import 'package:zilmoney_task/repositories/user_repository_impl.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  var dio = ref.read(dioProvider);
  return UserRepositoryImpl(dio);
});
