import 'package:flutter/material.dart';
import '../../../utils/get_it_setup.dart';
import '../../../widgets/app_list_tile.dart';
import '../../../widgets/app_stream_builder.dart';
import '../app_user.dart';
import '../user_service.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final UserService _userService = locator<UserService>();

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<List<AppUser>>(
      stream: _userService.usersStream,
      onData: (users) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return AppListTile(
            title: user.displayName,
            subtitle: user.email,
            onDelete: () => _userService.deleteUser(user.uid),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _userService.dispose();
    super.dispose();
  }
}
