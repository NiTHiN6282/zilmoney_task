import 'package:flutter/material.dart';
import 'package:zilmoney_task/models/user.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Name: ${user.name}"),
        Text("Username: ${user.username}"),
        Text("Email: ${user.email}"),
      ],
    );
  }
}
