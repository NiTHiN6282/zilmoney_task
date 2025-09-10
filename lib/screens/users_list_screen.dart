import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zilmoney_task/screens/add_user_screen.dart';
import 'package:zilmoney_task/screens/user_detail_screen.dart';
import 'package:zilmoney_task/widgets/user_card.dart';

import '../providers/users_list_provider.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class UsersListScreen extends ConsumerWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var usersData = ref.watch(userListProvider);
    return Scaffold(
      appBar: AppBar(title: Text("User List")),
      body: usersData.when(
        data: (users) {
          return RefreshIndicator(
            onRefresh: () => ref.refresh(userListProvider.future),
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailScreen(id: user.id!),
                      ),
                    );
                  },
                  child: UserCard(user: user),
                );
              },
            ),
          );
        },
        error: (error, stackTrace) => CustomErrorWidget(),
        loading: () => LoadingWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
