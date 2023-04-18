import 'package:flutter/material.dart';
import '../../utils/app_navigate.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_drawer.dart';
import 'widgets/branch_list.dart';

class BranchListScreen extends StatelessWidget {
  const BranchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de sucursales')),
      drawer: const AppDrawer(),
      body: const BranchList(),
      floatingActionButton: AppButtons.addFloatAction(
        () => AppNavigate.toBranch(context),
      ),
    );
  }
}
