import 'package:flutter/material.dart';
import '../../../utils/app_snack_bar.dart';
import '../../../widgets/app_buttons.dart';
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppFormFields.email(
              _emailController,
              onFieldSubmitted: (_) => _onSubmit(),
            ),
            AppFormFields.password(
              _passwordController,
              onFieldSubmitted: (_) => _onSubmit(),
            ),
            const SizedBox(height: 8),
            AppButtons.saveButton(onPressed: _onSubmit),
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      try {
        widget.onSubmit(_emailController.text, _passwordController.text);
      } on Exception catch (e) {
        AppSnackBar.showSnackBar(context, 'Error: $e');
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
