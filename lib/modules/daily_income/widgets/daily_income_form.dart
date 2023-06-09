import 'package:flutter/material.dart';
import '../../../utils/app_navigate.dart';
import '../../../utils/app_snack_bar.dart';
import '../../../widgets/app_buttons.dart';
import '../../../widgets/app_form_fields.dart';
import '../../branch/branch.dart';
import '../daily_income.dart';

class DailyIncomeForm extends StatefulWidget {
  final DailyIncome? dailyIncome;
  final Function(DailyIncome) onSubmit;

  const DailyIncomeForm({
    Key? key,
    required this.dailyIncome,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _DailyIncomeFormState createState() => _DailyIncomeFormState();
}

class _DailyIncomeFormState extends State<DailyIncomeForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  Branch? _branch;

  @override
  void initState() {
    super.initState();
    _initFormValues();
  }

  void _initFormValues() {
    if (widget.dailyIncome != null) {
      final dailyIncome = widget.dailyIncome!;
      _dateController.text = dailyIncome.date.toString();
      _branch = Branch(id: dailyIncome.branchId, name: dailyIncome.branchName);
      _amountController.text = dailyIncome.amount.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            AppFormFields.date(
              _dateController,
              onFieldSubmitted: (_) => _onSubmit(),
              enabled: widget.dailyIncome == null,
            ),
            AppFormFields.branchDropdown(
              branch: _branch,
              onChanged: (Branch? newValue) {
                setState(() {
                  _branch = newValue;
                });
              },
            ),
            AppFormFields.amount(
              _amountController,
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
          DailyIncome(
            id: widget.dailyIncome?.id ?? '',
            date: DateTime.parse(_dateController.text),
            amount: double.parse(_amountController.text),
            branchId: _branch!.id,
            branchName: _branch!.name,
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
    _dateController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
