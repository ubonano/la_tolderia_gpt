import 'package:flutter/material.dart';
import '../../utils/app_navigate.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_drawer.dart';
import 'widgets/daily_income_list.dart';

class DailyIncomeListScreen extends StatelessWidget {
  const DailyIncomeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingresos diarios')),
      drawer: const AppDrawer(),
      body: const DailyIncomeList(),
      floatingActionButton: AppButtons.addFloatAction(
        () => AppNavigate.toDailyIncome(context),
      ),
    );
  }
}
