import 'package:flutter/material.dart';
import '../../../utils/app_navigate.dart';
import '../../../utils/get_it_setup.dart';
import '../../../widgets/app_buttons.dart';
import '../../../widgets/app_list_tile.dart';
import '../../../widgets/app_stream_builder.dart';
import '../employee.dart';
import '../employee_service.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  final EmployeeService _employeeService = locator<EmployeeService>();

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<List<Employee>>(
      stream: _employeeService.employeesStream,
      onData: (employees) => ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          return AppListTile(
            title: '${employee.firstName} ${employee.lastName}',
            onEdit: () => AppNavigate.toEmployee(
              context,
              employee: employee,
            ),
            onDelete: () => _employeeService.deleteEmployee(employee.id),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _employeeService.dispose();
    super.dispose();
  }
}
