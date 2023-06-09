import 'package:flutter/material.dart';
import '../../../utils/app_navigate.dart';
import '../../../utils/app_snack_bar.dart';
import '../../../utils/get_it_setup.dart';
import '../../../widgets/app_buttons.dart';
import '../../../widgets/app_form_fields.dart';
import '../../branch/branch.dart';
import '../employee.dart';
import '../employee_service.dart';

class EmployeeForm extends StatefulWidget {
  final Employee? employee;
  final Function(Employee) onSubmit;

  const EmployeeForm({Key? key, required this.employee, required this.onSubmit})
      : super(key: key);

  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final _employeeService = locator<EmployeeService>();

  final _formKey = GlobalKey<FormState>();

  final _idController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  bool _isActive = true;
  Branch? _branch;

  @override
  void initState() {
    super.initState();
    _loadEmployeeData();
  }

  void _loadEmployeeData() {
    if (widget.employee != null) {
      final employee = widget.employee!;
      _idController.text = employee.identificationNumber;
      _firstNameController.text = employee.firstName;
      _lastNameController.text = employee.lastName;
      _phoneController.text = employee.phone;
      _emailController.text = employee.email;
      _addressController.text = employee.address;
      _isActive = employee.isActive;
      _branch = Branch(id: employee.branchId, name: employee.branchName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppFormFields.idNumber(
            _idController,
            onFieldSubmitted: (_) => _onSubmit(),
          ),
          AppFormFields.name(
            _firstNameController,
            onFieldSubmitted: (_) => _onSubmit(),
          ),
          AppFormFields.lastName(
            _lastNameController,
            onFieldSubmitted: (_) => _onSubmit(),
          ),
          AppFormFields.branchDropdown(
            branch: _branch,
            onChanged: (Branch? newValue) {
              _branch = newValue;
              setState(() {});
            },
          ),
          AppFormFields.phone(
            _phoneController,
            onFieldSubmitted: (_) => _onSubmit(),
          ),
          AppFormFields.email(
            _emailController,
            onFieldSubmitted: (_) => _onSubmit(),
          ),
          AppFormFields.address(
            _addressController,
            onFieldSubmitted: (_) => _onSubmit(),
          ),
          AppFormFields.isActiveSwitch(_isActive, (value) {
            _isActive = value;
            setState(() {});
          }),
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
          Employee(
            id: widget.employee != null ? widget.employee!.id : '',
            identificationNumber: _idController.text,
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            branchName: _branch!.name,
            branchId: _branch!.id,
            phone: _phoneController.text,
            email: _emailController.text,
            address: _addressController.text,
            isActive: _isActive,
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
    _idController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
