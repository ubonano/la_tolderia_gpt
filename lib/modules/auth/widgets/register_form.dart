import 'package:flutter/material.dart';
import '../../../widgets/app_form.dart';
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
    return AppForm(
      formKey: _formKey,
      backOnSubmit: false,
      onSubmit: () =>
          widget.onSubmit(_emailController.text, _passwordController.text),
      child: Column(
        children: [
          AppFormFields.email(_emailController),
          AppFormFields.password(_passwordController),
          AppFormFields.passwordConfirmation(
            _passwordConfirmationController,
            _passwordController,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }
}
