import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../daily_income.dart';

class DailyIncomeChart extends StatelessWidget {
  final List<DailyIncome> dailyIncomes;

  const DailyIncomeChart({super.key, required this.dailyIncomes});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Facturación'),
      ),
      legend: Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: _buildSeries(),
    );
  }

  List<LineSeries<DailyIncome, String>> _buildSeries() {
    return <LineSeries<DailyIncome, String>>[
      LineSeries<DailyIncome, String>(
        dataSource: dailyIncomes,
        xValueMapper: (DailyIncome dailyIncome, _) => dailyIncome.dateFormatted,
        yValueMapper: (DailyIncome dailyIncome, _) => dailyIncome.amount,
        name: 'Facturación por día',
        markerSettings: const MarkerSettings(isVisible: true),
      ),
      LineSeries<DailyIncome, String>(
        dataSource: _calculateAccumulatedDailyIncomes(dailyIncomes),
        xValueMapper: (DailyIncome dailyIncome, _) => dailyIncome.dateFormatted,
        yValueMapper: (DailyIncome dailyIncome, _) => dailyIncome.amount,
        name: 'Facturación acumulada',
        markerSettings: const MarkerSettings(isVisible: true),
      ),
    ];
  }

  List<DailyIncome> _calculateAccumulatedDailyIncomes(
      List<DailyIncome> dailyIncomes) {
    double accumulatedAmount = 0;
    List<DailyIncome> accumulatedDailyIncomes = [];

    for (DailyIncome dailyIncome in dailyIncomes) {
      accumulatedAmount += dailyIncome.amount;
      accumulatedDailyIncomes.add(
        DailyIncome(
          date: dailyIncome.date,
          branchId: dailyIncome.branchId,
          branchName: dailyIncome.branchName,
          amount: accumulatedAmount,
        ),
      );
    }

    return accumulatedDailyIncomes;
  }
}
