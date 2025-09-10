import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zilmoney_task/providers/user_repository_provider.dart';

import '../models/user.dart';

final userDetailProvider = FutureProvider.autoDispose.family<User, int>((
  ref,
  id,
) async {
  var repo = ref.read(userRepositoryProvider);
  return repo.fetchUser(id);
});
