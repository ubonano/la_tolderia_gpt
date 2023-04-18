import 'package:flutter/material.dart';
import '../../../widgets/app_form.dart';
import '../../../widgets/app_form_fields.dart';

class LoginForm extends StatefulWidget {
  final Future<void> Function(String email, String password) onSubmit;

  const LoginForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppForm(
      formKey: _formKey,
      backOnSubmit: false,
      onSubmit: () =>
          widget.onSubmit(_emailController.text, _passwordController.text),
      child: Column(
        children: [
          AppFormFields.email(_emailController),
          AppFormFields.password(_passwordController),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
