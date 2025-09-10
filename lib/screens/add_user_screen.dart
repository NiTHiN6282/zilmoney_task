import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zilmoney_task/models/user.dart';
import 'package:zilmoney_task/providers/user_repository_provider.dart';
import 'package:zilmoney_task/utils/utils.dart';
import 'package:zilmoney_task/widgets/loading_widget.dart';

class AddUserScreen extends ConsumerStatefulWidget {
  const AddUserScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends ConsumerState<AddUserScreen> {
  User user = User(name: "", username: "", email: "");

  bool creating = false;

  save() async {
    setState(() {
      creating = true;
    });

    var repo = ref.read(userRepositoryProvider);
    await repo.addUser(user);
    if (!mounted) return;
    Navigator.pop(context);
    showSnackBar(context, text: "Add successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Use")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(label: Text("Name")),
                initialValue: user.name,
                onChanged: (value) => user.name = value,
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Username")),
                initialValue: user.username,
                onChanged: (value) => user.username = value,
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Email")),
                initialValue: user.email,
                onChanged: (value) => user.email = value,
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Phone")),
                initialValue: user.phone,
                onChanged: (value) => user.phone = value,
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Website")),
                initialValue: user.website,
                onChanged: (value) => user.website = value,
              ),
              SizedBox(height: 20),
              creating
                  ? LoadingWidget()
                  : ElevatedButton(
                      onPressed: () {
                        save();
                      },
                      child: Text("Create"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
