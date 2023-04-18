import 'package:flutter/material.dart';
import '../modules/auth/auth_service.dart';
import '../utils/app_navigate.dart';
import '../utils/get_it_setup.dart';
import 'app_confirmation_dialog.dart';

class AppDrawerTiles {
  static Widget logoutButton(BuildContext context) {
    final authService = locator<AuthService>();
    return ListTile(
      leading: const Icon(Icons.logout),
      title: const Text('Cerrar sesión'),
      onTap: () => showDialog(
        context: context,
        builder: (context) => AppConfirmationDialog(
          content: '¿Está seguro de que desea cerrar sesión?',
          title: 'Cerrar sesión',
          onCancel: () => AppNavigate.back(context),
          onConfirm: () {
            authService.signOut();
            AppNavigate.back(context);
          },
        ),
      ),
    );
  }

  static Widget dailyIncomeButton(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.attach_money),
      title: const Text('Ingresos diarios'),
      onTap: () => AppNavigate.toDailyIncomeList(context),
    );
  }

  static Widget branchButton(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.store),
      title: const Text('Sucursales'),
      onTap: () => AppNavigate.toBranchList(context),
    );
  }

  static Widget employeeButton(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.people),
      title: const Text('Gestión de empleados'),
      onTap: () => AppNavigate.toEmployeeList(context),
    );
  }

  static Widget userButton(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person_pin_outlined),
      title: const Text('Usuarios'),
      onTap: () => AppNavigate.toUserScreenList(context),
    );
  }

  static Widget pointOfSaleButton(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.point_of_sale),
      title: const Text('Puntos de venta'),
      onTap: () => AppNavigate.toPointOfSaleList(context),
    );
  }
}
