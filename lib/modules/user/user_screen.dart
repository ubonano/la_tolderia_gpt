import 'package:flutter/material.dart';
import '../../../utils/get_it_setup.dart';
import 'user_service.dart';
import 'widgets/user_form.dart';
import 'app_user.dart';

class UserScreen extends StatelessWidget {
  final _userService = locator<UserService>();

  UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar usuario'),
      ),
      body: UserForm(
        onSubmit: (AppUser user) async {
          await _userService.registerUser(user);
        },
      ),
    );
  }
}
