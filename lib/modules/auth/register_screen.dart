import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'widgets/register_form.dart';
import '../../../utils/get_it_setup.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final _authService = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: RegisterForm(
        onSubmit: (email, password) async =>
            await _authService.signUp(email, password),
      ),
    );
  }
}
