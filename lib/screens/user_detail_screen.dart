import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zilmoney_task/providers/user_detail_provider.dart';
import 'package:zilmoney_task/providers/user_repository_provider.dart';
import 'package:zilmoney_task/widgets/error_widget.dart';
import 'package:zilmoney_task/widgets/loading_widget.dart';

import '../utils/utils.dart';
import 'edit_user_screen.dart';

class UserDetailScreen extends ConsumerStatefulWidget {
  final int id;
  const UserDetailScreen({super.key, required this.id});

  @override
  ConsumerState<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends ConsumerState<UserDetailScreen> {
  delete() async {
    var repo = ref.read(userRepositoryProvider);
    await repo.deleteUser(widget.id);
    if (!mounted) return;
    Navigator.pop(context);
    showSnackBar(context, text: "Delete successfully");
  }

  @override
  Widget build(BuildContext context) {
    var userData = ref.watch(userDetailProvider(widget.id));
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: userData.when(
        data: (user) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${user.name}"),
                Text("Username: ${user.username}"),
                Text("Email: ${user.email}"),
                if (user.phone != null) Text("Phone: ${user.phone}"),
                if (user.website != null) Text("Website: ${user.website}"),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditUserScreen(user: user),
                          ),
                        );
                        setState(() {});
                      },
                      child: Text("Edit"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        delete();
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          print(error);
          return CustomErrorWidget();
        },
        loading: () => LoadingWidget(),
      ),
    );
  }
}
