import 'package:flutter/material.dart';
import 'employee.dart';
import 'employee_service.dart';
import 'widget/employee_form.dart';
import '../../../utils/get_it_setup.dart';

class EmployeeScreen extends StatelessWidget {
  final Employee? employee;
  final _employeeService = locator<EmployeeService>();

  EmployeeScreen({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(employee == null ? 'Registrar empleado' : 'Editar empleado'),
      ),
      body: EmployeeForm(
        employee: employee,
        onSubmit: (Employee employee) async {
          employee.id.isEmpty
              ? await _employeeService.addEmployee(employee)
              : await _employeeService.updateEmployee(employee);
        },
      ),
    );
  }
}
