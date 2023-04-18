import 'package:flutter/material.dart';
import '../../utils/get_it_setup.dart';
import 'daily_income.dart';
import 'daily_income_service.dart';
import 'widgets/daily_income_form.dart';

class DailyIncomeScreen extends StatelessWidget {
  final DailyIncome? dailyIncome;
  final _dailyIncomeService = locator<DailyIncomeService>();

  DailyIncomeScreen({Key? key, required this.dailyIncome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          dailyIncome == null
              ? 'Registrar ingreso diario'
              : 'Editar ingreso diario',
        ),
      ),
      body: DailyIncomeForm(
        dailyIncome: dailyIncome,
        onSubmit: (dailyIncome) async {
          this.dailyIncome == null
              ? await _dailyIncomeService.addDailyIncome(dailyIncome)
              : await _dailyIncomeService.updateDailyIncome(dailyIncome);
        },
      ),
    );
  }
}
