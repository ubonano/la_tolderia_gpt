import 'package:flutter/material.dart';
import '../../utils/app_navigate.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_drawer.dart';
import 'widgets/user_list.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuarios')),
      drawer: const AppDrawer(),
      body: const UserList(),
      floatingActionButton: AppButtons.addFloatAction(
        () => AppNavigate.toUserScreen(context),
      ),
    );
  }
}
