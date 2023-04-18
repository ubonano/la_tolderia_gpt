import 'package:flutter/material.dart';
import '../../utils/app_navigate.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_drawer.dart';
import 'widget/employee_list.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de empleados')),
      drawer: const AppDrawer(),
      body: const EmployeeList(),
      floatingActionButton: AppButtons.addFloatAction(
        () => AppNavigate.toEmployee(context),
      ),
    );
  }
}
