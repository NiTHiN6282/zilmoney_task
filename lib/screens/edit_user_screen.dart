import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zilmoney_task/models/user.dart';
import 'package:zilmoney_task/providers/user_repository_provider.dart';
import 'package:zilmoney_task/utils/utils.dart';
import 'package:zilmoney_task/widgets/loading_widget.dart';

class EditUserScreen extends ConsumerStatefulWidget {
  User user;
  EditUserScreen({super.key, required this.user});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends ConsumerState<EditUserScreen> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  bool saving = false;

  save() async {
    setState(() {
      saving = true;
    });

    var repo = ref.read(userRepositoryProvider);
    await repo.editUser(user);
    if (!mounted) return;
    Navigator.pop(context);
    showSnackBar(context, text: "Edit successfully");
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
                initialValue: user.name,
                onChanged: (value) => user.name = value,
              ),
              TextFormField(
                initialValue: user.username,
                onChanged: (value) => user.username = value,
              ),
              TextFormField(
                initialValue: user.email,
                onChanged: (value) => user.email = value,
              ),
              TextFormField(
                initialValue: user.phone,
                onChanged: (value) => user.phone = value,
              ),
              TextFormField(
                initialValue: user.website,
                onChanged: (value) => user.website = value,
              ),
              SizedBox(height: 20),
              saving
                  ? LoadingWidget()
                  : ElevatedButton(
                      onPressed: () {
                        save();
                      },
                      child: Text("Save"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
