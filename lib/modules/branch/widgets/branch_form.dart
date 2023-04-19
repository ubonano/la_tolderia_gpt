import 'package:flutter/material.dart';
import '../../../utils/app_navigate.dart';
import '../../../utils/app_snack_bar.dart';
import '../../../widgets/app_buttons.dart';
import '../../../widgets/app_form_fields.dart';
import '../branch.dart';

class BranchForm extends StatefulWidget {
  final Branch? branch;
  final Function(Branch) onSubmit;

  const BranchForm({Key? key, this.branch, required this.onSubmit})
      : super(key: key);

  @override
  _BranchFormState createState() => _BranchFormState();
}

class _BranchFormState extends State<BranchForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.branch?.name ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppFormFields.name(
              _nameController,
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
        widget.onSubmit(
          Branch(
            id: widget.branch?.id ?? '',
            name: _nameController.text,
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
    _nameController.dispose();
    super.dispose();
  }
}
