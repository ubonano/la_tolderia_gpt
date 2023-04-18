import 'package:flutter/material.dart';
import '../../utils/get_it_setup.dart';
import 'auth_service.dart';
import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _authService = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: LoginForm(
        onSubmit: (email, password) async =>
            await _authService.signIn(email, password),
      ),
    );
  }
}
