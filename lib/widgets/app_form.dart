import 'package:flutter/material.dart';
import '../utils/app_navigate.dart';
import 'app_buttons.dart';
import '../../../utils/app_snack_bar.dart';

class AppForm extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onSubmit;
  final GlobalKey<FormState> formKey;
  final bool backOnSubmit;

  const AppForm({
    Key? key,
    this.backOnSubmit = true,
    required this.child,
    required this.onSubmit,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            child,
            const SizedBox(height: 8),
            AppButtons.saveButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    await onSubmit();
                    backOnSubmit ? AppNavigate.back(context) : null;
                  } on Exception catch (e) {
                    AppSnackBar.showSnackBar(context, 'Error: $e');
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
