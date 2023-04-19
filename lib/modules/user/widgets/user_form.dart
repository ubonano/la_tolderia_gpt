import 'package:flutter/material.dart';
import '../../../utils/app_navigate.dart';
import '../../../utils/app_snack_bar.dart';
import '../../../widgets/app_buttons.dart';
import '../../../widgets/app_form_fields.dart';
import '../app_user.dart';

class UserForm extends StatefulWidget {
  final Function(AppUser) onSubmit;
  const UserForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          AppFormFields.email(
            _emailController,
            onFieldSubmitted: (_) => _onSubmit(),
          ),
          AppFormFields.name(
            _displayNameController,
            onFieldSubmitted: (_) => _onSubmit(),
          ),
          AppFormFields.password(
            _passwordController,
            onFieldSubmitted: (_) => _onSubmit(),
          ),
          AppFormFields.passwordConfirmation(
            _confirmPasswordController,
            _passwordController,
            onFieldSubmitted: (_) => _onSubmit(),
          ),
          const SizedBox(height: 8),
          AppButtons.saveButton(onPressed: _onSubmit),
        ],
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      try {
        widget.onSubmit(
          AppUser(
            uid: '',
            email: _emailController.text,
            displayName: _displayNameController.text,
            password: _passwordController.text,
          ),
        );

        AppNavigate.back(context);
      } on Exception catch (e) {
        AppSnackBar.showSnackBar(context, 'Error: $e');
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _displayNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
