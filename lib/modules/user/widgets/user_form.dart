import 'package:flutter/material.dart';
import '../../../widgets/app_form.dart';
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
    return AppForm(
      formKey: _formKey,
      child: Column(
        children: <Widget>[
          AppFormFields.email(_emailController),
          AppFormFields.name(_displayNameController),
          AppFormFields.password(_passwordController),
          AppFormFields.passwordConfirmation(
            _confirmPasswordController,
            _passwordController,
          ),
        ],
      ),
      onSubmit: () => widget.onSubmit(
        AppUser(
          uid: '',
          email: _emailController.text,
          displayName: _displayNameController.text,
          password: _passwordController.text,
        ),
      ),
    );
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
