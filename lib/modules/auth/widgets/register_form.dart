import 'package:flutter/material.dart';
import '../../../utils/app_navigate.dart';
import '../../../utils/app_snack_bar.dart';
import '../../../widgets/app_buttons.dart';
import '../../../widgets/app_form_fields.dart';

class RegisterForm extends StatefulWidget {
  final Future<void> Function(String email, String password) onSubmit;

  const RegisterForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

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
            AppFormFields.passwordConfirmation(
              _passwordConfirmationController,
              _passwordController,
              onFieldSubmitted: (_) => _onSubmit(),
            ),
            const SizedBox(height: 8),
            AppButtons.registerButton(onPressed: _onSubmit),
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
    _passwordConfirmationController.dispose();
    super.dispose();
  }
}
