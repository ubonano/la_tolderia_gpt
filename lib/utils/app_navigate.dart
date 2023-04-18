import 'package:flutter/material.dart';
import '../modules/auth/register_screen.dart';
import '../modules/branch/branch.dart';
import '../modules/branch/branch_list_screen.dart';
import '../modules/branch/branch_screen.dart';
import '../modules/daily_income/daily_income.dart';
import '../modules/daily_income/daily_income_list_screen.dart';
import '../modules/daily_income/daily_income_screen.dart';
import '../modules/employee/employee.dart';
import '../modules/employee/employee_list_screen.dart';
import '../modules/employee/employee_screen.dart';
import '../modules/point_of_sale/point_of_sale.dart';
import '../modules/point_of_sale/point_of_sale_form_screen.dart';
import '../modules/point_of_sale/point_of_sale_list_screen.dart';
import '../modules/user/user_list_screen.dart';
import '../modules/user/user_screen.dart';

class AppNavigate {
  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  static void toRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      ),
    );
  }

  static void toBranch(BuildContext context, {Branch? branch}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BranchScreen(branch: branch),
      ),
    );
  }

  static void toBranchList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BranchListScreen(),
      ),
    );
  }

  static void toDailyIncome(BuildContext context, {DailyIncome? dailyIncome}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DailyIncomeScreen(dailyIncome: dailyIncome),
      ),
    );
  }

  static void toDailyIncomeList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DailyIncomeListScreen(),
      ),
    );
  }

  static void toEmployee(BuildContext context, {Employee? employee}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmployeeScreen(employee: employee),
      ),
    );
  }

  static void toEmployeeList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmployeeListScreen(),
      ),
    );
  }

  static void toPointOfSale(BuildContext context, {PointOfSale? pointOfSale}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PointOfSaleScreen(pointOfSale: pointOfSale),
      ),
    );
  }

  static void toPointOfSaleList(
    BuildContext context,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PointOfSaleListScreen(),
      ),
    );
  }

  static void toUserScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserScreen(),
      ),
    );
  }

  static void toUserScreenList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserListScreen(),
      ),
    );
  }
}
