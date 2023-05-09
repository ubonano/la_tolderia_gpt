import 'package:flutter/material.dart';
import '../../../utils/app_navigate.dart';
import '../../../utils/get_it_setup.dart';
import '../../../widgets/app_3d_button.dart';
import '../../../widgets/app_list_tile.dart';
import '../../../widgets/app_stream_builder.dart';
import '../daily_income.dart';
import 'daily_income_chart.dart';
import '../daily_income_service.dart';

class DailyIncomeList extends StatefulWidget {
  const DailyIncomeList({Key? key}) : super(key: key);

  @override
  State<DailyIncomeList> createState() => _DailyIncomeListState();
}

class _DailyIncomeListState extends State<DailyIncomeList> {
  final _dailyIncomeService = locator<DailyIncomeService>();

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<List<DailyIncome>>(
      stream: _dailyIncomeService.getDailyIncomes(),
      onData: (dailyIncomes) {
        final totalAmount = _calculateTotalAmount(dailyIncomes);

        return Column(
          children: [
            _buildTotalAmountText(totalAmount),
            DailyIncomeChart(dailyIncomes: dailyIncomes),
            Expanded(child: _buildDailyIncomesListView(dailyIncomes)),
          ],
        );
      },
    );
  }

  double _calculateTotalAmount(List<DailyIncome> dailyIncomes) {
    return dailyIncomes.fold(0.0, (sum, item) => sum + item.amount);
  }

  Widget _buildTotalAmountText(double totalAmount) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text('Total facturado: \$${totalAmount.toStringAsFixed(2)}'),
    );
  }

  Widget _buildDailyIncomesListView(List<DailyIncome> dailyIncomes) {
    return ListView.builder(
      itemCount: dailyIncomes.length,
      itemBuilder: (BuildContext context, int index) {
        final dailyIncome = dailyIncomes[index];

        return AppListTile(
          title:
              '${dailyIncome.dateFormatted} - ${dailyIncome.branchName} - \$${dailyIncome.amount.toStringAsFixed(2)}',
          onEdit: () => AppNavigate.toDailyIncome(
            context,
            dailyIncome: dailyIncome,
          ),
          onDelete: () => _dailyIncomeService.deleteDailyIncome(dailyIncome.id),
        );
      },
    );
  }

  @override
  void dispose() {
    _dailyIncomeService.dispose();
    super.dispose();
  }
}
