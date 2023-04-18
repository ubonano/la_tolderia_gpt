import 'package:flutter/material.dart';
import '../../../widgets/app_form.dart';
import '../../../widgets/app_form_fields.dart';
import '../../branch/branch.dart';
import '../point_of_sale.dart';

typedef OnSaveCallback = Future<void> Function(PointOfSale pointOfSale);

class PointOfSaleForm extends StatefulWidget {
  final PointOfSale? pointOfSale;
  final OnSaveCallback onSubmit;

  const PointOfSaleForm({Key? key, this.pointOfSale, required this.onSubmit})
      : super(key: key);

  @override
  _PointOfSaleFormState createState() => _PointOfSaleFormState();
}

class _PointOfSaleFormState extends State<PointOfSaleForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  Branch? _branch;

  @override
  void initState() {
    super.initState();

    if (widget.pointOfSale != null) {
      _nameController.text = widget.pointOfSale!.name;
      _branch = Branch(
        id: widget.pointOfSale!.branchId,
        name: widget.pointOfSale!.branchName,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppForm(
      formKey: _formKey,
      child: Column(
        children: [
          AppFormFields.name(_nameController),
          AppFormFields.branchDropdown(
            branch: _branch,
            onChanged: (Branch? newValue) {
              setState(() {
                _branch = newValue;
              });
            },
          ),
        ],
      ),
      onSubmit: () => widget.onSubmit(
        PointOfSale(
          id: widget.pointOfSale?.id ?? '',
          name: _nameController.text,
          branchId: _branch!.id,
          branchName: _branch!.name,
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
