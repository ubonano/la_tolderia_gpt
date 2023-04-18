import 'package:flutter/material.dart';
import '../../../widgets/app_form.dart';
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
    return AppForm(
      formKey: _formKey,
      child: Column(
        children: [
          AppFormFields.name(_nameController),
        ],
      ),
      onSubmit: () => widget.onSubmit(
        Branch(
          id: widget.branch?.id ?? '',
          name: _nameController.text,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
