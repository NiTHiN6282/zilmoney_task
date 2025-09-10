import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zilmoney_task/providers/user_repository_provider.dart';

import '../models/user.dart';

final userListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
  var repo = ref.read(userRepositoryProvider);
  return repo.fetchUsers();
});
